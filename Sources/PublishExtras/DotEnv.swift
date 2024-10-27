//
//  DotEnv.swift
//  PublishExtras
//
//  Based on https://github.com/fborges/Environmentalism by Felipe Borges
//

import Files
import Foundation

/// An abstraction that takes care of handling variables contained into your DotEnv files.
public enum DotEnv {
    /// An error that occurs while reading a dotenv file.
    public enum Error: Equatable, LocalizedError {
        /// The dotenv file was not found.
        case fileNotFound(String)
        /// The dotenv file was not in the expected format.
        case invalidFormat

        public var errorDescription: String? {
            switch self {
            case .fileNotFound(let filePath):
                "Unable to locate the .env file at `\(filePath)`."
            case .invalidFormat:
                "The .env file has an invalid format."
            }
        }
    }

    /// Loads a dotenv in the root directory with the given name.
    ///
    /// - Parameters:
    ///   - fileName: The name of the dotenv file.
    ///   - file: The file from which this method is called.
    public static func load(_ fileName: String = ".env", file: StaticString = #filePath) throws {
        let rootPath = try resolveSwiftPackageFolder(of: "\(file)")
        #if os(Linux)
        let filePath = rootPath.appendingPathComponent(fileName).path
        #else
        let filePath = rootPath.appending(path: fileName).path()
        #endif

        if !FileManager.default.fileExists(atPath: filePath) {
            throw Error.fileNotFound(filePath)
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

    private static func resolveSwiftPackageFolder(of path: String) throws -> URL {
        guard let file = try? File(path: path) else {
            throw Error.fileNotFound(path)
        }

        var nextFolder = file.parent

        while let currentFolder = nextFolder {
            if currentFolder.containsFile(named: "Package.swift") {
                return currentFolder.url
            }

            nextFolder = currentFolder.parent
        }

        throw Error.fileNotFound("Package.swift")
    }
}
