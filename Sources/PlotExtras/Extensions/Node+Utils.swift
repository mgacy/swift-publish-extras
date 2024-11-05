//
//  Node+Utils.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 10/27/24.
//  Copyright © 2024 Mobelux. All rights reserved.
//

import Foundation
import Plot

public extension Node where Context: HTML.BodyContext {
    /// Adds an `<address>` HTML element within the current context.
    ///
    /// - parameter nodes: The element's attributes and child elements.
    static func address(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .element(named: "address", nodes: nodes)
    }

    /// Adds a `<hgroup>` HTML element within the current context.
    ///
    /// - parameter nodes: The element's attributes and child elements.
    static func hgroup(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .element(named: "hgroup", nodes: nodes)
    }

    /// Adds a `<search>` HTML element within the current context.
    ///
    /// - parameter nodes: The element's attributes and child elements.
    static func search(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .element(named: "search", nodes: nodes)
    }
}

public extension Node where Context: HTMLMediaContext {
    /// Assigns whether the element's media should play automatically.
    ///
    /// - Parameter enableAutoplay: Whether autoplay should be enabled.
    static func autoplay(_ enableAutoplay: Bool) -> Node {
        enableAutoplay ? .attribute(named: "autoplay") : .empty
    }

    /// Assigns whether the element's media should loop.
    ///
    /// - Parameter enableLoop: Whether looping should be enabled.
    static func loop(_ enableLoop: Bool) -> Node {
        enableLoop ? .attribute(named: "loop") : .empty
    }

    /// Assigns whether the element's media should be muted.
    ///
    /// - Parameter enableMuted: Whether the media should be muted.
    static func muted(_ enableMuted: Bool) -> Node {
        enableMuted ? .attribute(named: "muted") : .empty
    }

    /// Assigns whether the element's media should play inline.
    ///
    /// - Parameter enablePlaysinline: Whether the media should play inline.
    static func playsinline(_ enablePlaysinline: Bool) -> Node {
        enablePlaysinline ? .attribute(named: "playsinline") : .empty
    }
}

public extension Node where Context == HTML.VideoContext {
    /// Assigns an image to display while the video is downloading, or until the user hits the play
    /// button.
    ///
    /// - Parameter url: The poster URL to assign.
    static func poster(_ url: URLRepresentable) -> Node {
        .attribute(named: "poster", value: url.description)
    }
}
