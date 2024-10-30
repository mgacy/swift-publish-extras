//
//  EnvironmentVariable.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 4/25/24.
//  Copyright © 2024 Mobelux. All rights reserved.
//

import Foundation

/// A representation of an environment variable's name and type.
public struct EnvironmentVariable<T>: Equatable, Sendable {
    /// The name of the environment value.
    public let name: String

    /// Creates an instance.
    ///
    /// - Parameter name: The name of the environment value.
    public init(_ name: String) {
        self.name = name
    }
}

extension EnvironmentVariable: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.name = value
    }
}

/// An error that occurs while accessing environment values.
public enum EnvironmentError: Error {
    /// There was an error converting an environment variable value to the expected type.
    case conversionFailure
    /// The environment did not contain a value for the given environment variable name.
    case missingValue(String)
}

public extension Dictionary<String, String> {
    /// Returns the value for the given environment variable.
    ///
    /// - Parameter variable: The variable for which the value should be returned.
    /// - Returns: The value of the environment variable.
    func value(_ variable: EnvironmentVariable<Bool>) throws -> Bool {
        try Bool(try getValue(for: variable).lowercased())
            .unwrap(or: EnvironmentError.conversionFailure)
    }

    /// Returns the value for the given environment variable.
    ///
    /// - Parameter variable: The variable for which the value should be returned.
    /// - Returns: The value of the environment variable.
    func value(_ variable: EnvironmentVariable<Bool?>) throws -> Bool? {
        self[variable.name].flatMap { Bool($0.lowercased()) }
    }

    /// Returns the value for the given environment variable.
    ///
    /// - Parameter variable: The variable for which the value should be returned.
    /// - Returns: The value of the environment variable.
    func value(_ variable: EnvironmentVariable<Int>) throws -> Int {
        try Int(try getValue(for: variable)).unwrap(or: EnvironmentError.conversionFailure)
    }

    /// Returns the value for the given environment variable.
    ///
    /// - Parameter variable: The variable for which the value should be returned.
    /// - Returns: The value of the environment variable.
    func value(_ variable: EnvironmentVariable<Int?>) throws -> Int? {
        self[variable.name].flatMap(Int.init)
    }

    /// Returns the value for the given environment variable.
    ///
    /// - Parameter variable: The variable for which the value should be returned.
    /// - Returns: The value of the environment variable.
    func value(_ variable: EnvironmentVariable<String>) throws -> String {
        try getValue(for: variable)
    }

    /// Returns the value for the given environment variable.
    ///
    /// - Parameter variable: The variable for which the value should be returned.
    /// - Returns: The value of the environment variable.
    func value(_ variable: EnvironmentVariable<String?>) throws -> String? {
        self[variable.name]
    }

    /// Returns the value for the given environment variable.
    ///
    /// - Parameter variable: The variable for which the value should be returned.
    /// - Returns: The value of the environment variable.
    func value(_ variable: EnvironmentVariable<URL>) throws -> URL {
        try URL(string: getValue(for: variable)).unwrap(or: EnvironmentError.conversionFailure)
    }

    /// Returns the value for the given environment variable.
    ///
    /// - Parameter variable: The variable for which the value should be returned.
    /// - Returns: The value of the environment variable.
    func value(_ variable: EnvironmentVariable<URL?>) throws -> URL? {
        try self[variable.name].flatMap { try URL(string: $0).unwrap(or: EnvironmentError.conversionFailure) }
    }

    private func getValue<T>(for variable: EnvironmentVariable<T>) throws -> String {
        try self[variable.name].unwrap(or: EnvironmentError.missingValue(variable.name))
    }
}
