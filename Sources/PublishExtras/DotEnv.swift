//
//  DotEnv.swift
//  PublishExtras
//
//  Based on https://github.com/fborges/Environmentalism by Felipe Borges
//

import Foundation

/// An abstraction that takes care of handling variables contained into your DotEnv files.
public enum DotEnv {
    /// An error that occurs while reading a dotenv file.
    public enum Error: Swift.Error {
        /// The dotenv file was not found.
        case fileNotFound
        /// The dotenv file was not in the expected format.
        case invalidFormat
    }

    /// Loads a dotenv in the root directory with the given name.
    ///
    /// - Parameter fileName: The name of the dotenv file.
    public static func load(_ fileName: String = ".env") throws {
        let rootPath = try parent(of: "Sources")
        #if os(Linux)
        let filePath = rootPath.appendingPathComponent(fileName).path
        #else
        let filePath = rootPath.appending(path: fileName).path()
        #endif

        if !FileManager.default.fileExists(atPath: filePath) {
            throw Error.fileNotFound
        }

        let lines = try String(contentsOfFile: filePath, encoding: .utf8).split(separator: "\n")
        for line in lines {
            // Ignore comments and empty lines
            if line[line.startIndex] == "#" || line.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
                return
            }

            let parts = line.split(separator: "=", maxSplits: 1)
            guard parts.count == 2 else {
                throw Error.invalidFormat
            }

            let key = parts[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            var value = parts[1].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

            if value[value.startIndex] == "\"" && value[value.index(before: value.endIndex)] == "\"" {
                value.remove(at: value.startIndex)
                value.remove(at: value.index(before: value.endIndex))
                value = value.replacingOccurrences(of: "\\\"", with: "\"")
            }

            setenv(key, value, 1)
        }
    }

    private static func parent(of directory: String) throws -> URL {
        var pathComponents = URL(fileURLWithPath: #file).pathComponents
        var foundDirectory = false
        while let component = pathComponents.last {
            if foundDirectory {
                break
            } else if component == directory {
                foundDirectory = true
            }

            pathComponents.removeLast()
        }

        guard pathComponents.isNotEmpty else {
            throw Error.fileNotFound
        }

        return URL(fileURLWithPath: pathComponents.joined(separator: "/"))
    }
}
