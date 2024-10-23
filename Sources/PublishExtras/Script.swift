//
//  Script.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 10/31/23.
//  Copyright © 2023 Mobelux. All rights reserved.
//

import Foundation
import Plot
@preconcurrency import Publish

/// A context-independent representation of a `<script>` element and its attributes.
public struct Script: Sendable {
    /// A representation of how a script is provided.
    public enum Source: Sendable {
        /// The script is embedded in the element.
        case inline(String)
        /// The script is loaded from an external URI.
        case external(Path)
    }

    /// A representation of how an external script should be downloaded and executed.
    public enum LoadingBehavior: Sendable {
        /// The script is downloaded in parallel to parsing the page, and executed as soon as it is
        /// available (before parsing completes).
        ///
        /// For more information, see the [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script#async).
        case async
        /// The script is downloaded in parallel to parsing the page, and executed after the page
        /// has finished parsing.
        ///
        /// For more information, see the [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script#defer).
        case deferred
    }

    /// A representation of a script element's `type`.
    ///
    /// For more information, see the [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script/type).
    public enum ScriptType: AttributeConvertible, Sendable {
        /// A standard to describe documents in other forms besides ASCII text.
        public typealias MIME = String

        public static let attributeName = "type"

        /// Indicates that the script is a "classic script", containing JavaScript code. 
        ///
        /// Authors are encouraged to omit the attribute if the script refers to JavaScript code
        /// rather than specify a MIME type.
        ///
        /// For more information, see the [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script#attribute_is_not_set_default_an_empty_string_or_a_javascript_mime_type).
        case classic(MIME?)
        /// Indicates that the body of the element contains an import map.
        ///
        /// The import map is a JSON object that developers can use to control how the browser
        /// resolves module specifiers when importing JavaScript modules.
        ///
        /// For more information, see the [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script/type/importmap).
        case importmap
        /// Indicates that the code to be treated as a JavaScript module.
        ///
        /// The processing of the script contents is deferred. The charset and defer attributes have
        /// no effect. Unlike classic scripts, module scripts require the use of the CORS protocol
        /// for cross-origin fetching.
        ///
        /// For more information, see the [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script#module).
        case module

        public var value: String {
            switch self {
            case .classic(let mime):
                return mime != nil ? mime! : ""
            case .importmap:
                return "importmap"
            case .module:
                return "module"
            }
        }
    }

    /// How the script is provided.
    public let source: Source

    /// How an external script should be downloaded and executed.
    ///
    /// If no value is specified, the script is downloaded and executed immediately, blocking parsing
    /// until the script is completed.
    public let loadingBehavior: LoadingBehavior?

    /// The script element's `type`.
    public let type: ScriptType?

    internal init(
        source: Source,
        loadingBehavior: LoadingBehavior? = nil,
        type: ScriptType? = nil
    ) {
        self.source = source
        self.loadingBehavior = loadingBehavior
        self.type = type
    }
}

public extension Script {
    /// Returns an element with an external script that will be loaded in `async` mode.
    ///
    /// - Parameters:
    ///   - path: The path to the script resource.
    ///   - type: The type of the script.
    static func async(_ path: Path, type: ScriptType? = nil) -> Self {
        .init(source: .external(path), loadingBehavior: .async, type: type)
    }

    /// Returns an element with an external script that will be loaded in `defer` mode.
    ///
    /// - Parameters:
    ///   - path: The path to the script resource.
    ///   - type: The type of the script.
    static func `defer`(_ path: Path, type: ScriptType? = nil) -> Self {
        .init(source: .external(path), loadingBehavior: .deferred, type: type)
    }

    /// Returns an element with an external script.
    ///
    /// - Parameters:
    ///   - path: The path to the script resource.
    ///   - type: The type of the script.
    static func immediate(_ path: Path, type: ScriptType? = nil) -> Self {
        .init(source: .external(path), loadingBehavior: nil, type: type)
    }

    /// Returns an element with an embedded script.
    ///
    /// - Parameters:
    ///   - javascript: The embedded script.
    ///   - type: The type of the script.
    static func inline(_ javascript: String, type: ScriptType? = nil) -> Self {
        .init(source: .inline(javascript), loadingBehavior: nil, type: type)
    }
}

public extension Script {
    /// Returns a `<script>` element with the appropriate context.
    func node<T: HTMLScriptableContext>() -> Node<T> {
        var nodes: [Node<HTML.ScriptContext>] = []

        if let type {
            nodes.append(.type(type))
        }

        switch source {
        case .inline(let source):
            nodes.append(.raw(source))

        case .external(let path):
            nodes.append(.src(path.absoluteString))

            switch loadingBehavior {
            case .async:
                nodes.append(.async())
            case .deferred:
                nodes.append(.defer())
            case .none:
                break
            }
        }

        return .element(named: "script", nodes: nodes)
    }
}
