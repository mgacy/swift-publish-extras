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
}

/// A container component that's rendered using the `<i>` element.
public typealias Idiomatic = ElementComponent<ElementDefinitions.Idiomatic>

/// A container component that's renered using the `<main>` element.
public typealias Main = ElementComponent<ElementDefinitions.Main>
