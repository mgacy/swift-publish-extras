//
//  InputPattern.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 4/15/24.
//  Copyright © 2024 Mobelux. All rights reserved.
//

import Foundation

/// A pattern for user input validation.
public struct InputPattern: Equatable, Sendable {
    /// The pattern to match.
    public let value: String

    /// Creates an instance with the given pattern.
    ///
    /// - Parameter value: The pattern to match.
    public init(_ value: String) {
        self.value = value
    }
}

extension InputPattern: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }
}

public extension InputPattern {
    /// A pattern for matching email addresses.
    static let email = Self(#"[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$"#)
}
