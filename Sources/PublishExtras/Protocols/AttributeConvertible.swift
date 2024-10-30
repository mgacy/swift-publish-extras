//
//  AttributeConvertible.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 10/31/23.
//  Copyright © 2023 Mobelux. All rights reserved.
//

import Foundation
import Plot

/// A class of types representing an element attribute and its value.
///
/// Use this type to improve the ergonomics of representing attributes that only allow specific
/// values.
public protocol AttributeConvertible {
    /// The name of the attribute.
    static var attributeName: String { get }

    /// The value of the attribute.
    var value: String { get }
}

public extension AttributeConvertible {
    /// Returns an attribute.
    func attribute<Context>() -> Attribute<Context> {
        Attribute(name: Self.attributeName, value: value, ignoreIfValueIsEmpty: true)
    }
}

public extension AttributeConvertible where Self: RawRepresentable<String> {
    var value: String {
        rawValue
    }
}

// MARK: - Node+AttributeConvertible
public extension Node {
    /// Creates a custom attribute with a given representation.
    ///
    /// - Parameter representation: The representation of the attribute.
    static func attribute<R: AttributeConvertible>(_ representation: R) -> Node {
        .attribute(representation.attribute())
    }
}
