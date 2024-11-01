//
//  AdditionalHTML.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 6/27/23.
//  Copyright © 2023 Mobelux. All rights reserved.
//

import Foundation
@preconcurrency import Plot

// MARK: - Element-based

public extension ElementDefinitions {
    /// Definition for the `<address>` element.
    enum Address: ElementDefinition {
        public typealias InputContext = HTML.BodyContext
        public typealias OutputContext = HTML.BodyContext

        public static let wrapper = Node.address
    }

    /// Definition for the `<hgroup>` element.
    enum HeaderGroup: ElementDefinition {
        public typealias InputContext = HTML.BodyContext
        public typealias OutputContext = HTML.BodyContext

        public static let wrapper = Node.hgroup
    }

    /// Definition for the `<i>` element.
    enum Idiomatic: ElementDefinition {
        public typealias InputContext = HTML.BodyContext
        public typealias OutputContext = HTML.BodyContext

        public static let wrapper = Node.i
    }

    /// Definition for the `<main>` element.
    enum Main: ElementDefinition {
        public typealias InputContext = HTML.BodyContext
        public typealias OutputContext = HTML.BodyContext

        public static let wrapper = Node.main
    }

    /// Definition for the `<search>` element.
    enum Search: ElementDefinition {
        public typealias InputContext = HTML.BodyContext
        public typealias OutputContext = HTML.BodyContext

        public static let wrapper = Node.search
    }
}

/// A container component that's rendered using the `<i>` element.
public typealias Address = ElementComponent<ElementDefinitions.Address>

/// A container component that's rendered using the `<i>` element.
public typealias HeaderGroup = ElementComponent<ElementDefinitions.HeaderGroup>

/// A container component that's rendered using the `<i>` element.
public typealias Idiomatic = ElementComponent<ElementDefinitions.Idiomatic>

/// A container component that's renered using the `<main>` element.
public typealias Main = ElementComponent<ElementDefinitions.Main>

/// A container component that's renered using the `<search>` element.
public typealias Search = ElementComponent<ElementDefinitions.Search>
