//
//  Route.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 6/22/23.
//  Copyright © 2023 Mobelux. All rights reserved.
//

import Foundation
import Plot
import Publish

/// A class of types providing the path, title, and description of a location.
public protocol Route {
    /// The path of a location.
    var path: Path { get }

    /// The location's title.
    var title: String { get }

    /// A description of the location.
    var description: String { get }
}

public extension Route where Self: RawRepresentable, Self.RawValue == String {
    var path: Path {
        Path(rawValue)
    }
}

// MARK: - Link+Route
public extension Link {
    /// Create a new link instance.
    ///
    /// - Parameters:
    ///   - route: The route for the location the link should point to.
    ///   - label: A closure that provides the components that should make up the link's label.
    init<R: Route>(route: R, @ComponentBuilder label: @escaping ContentProvider) {
        self.init(url: route.path.string, label: label)
    }
}

// MARK: - Page+Route
public extension Page {
    /// Initialize a new page programmatically.
    ///
    /// - Parameters:
    ///   - route: The route for the page.
    ///   - date: The location's main publishing date.
    ///   - lastModified: The last modification date.
    ///   - imagePath: A path to any image for the location.
    ///   - audio: Any audio data associated with this content.
    ///   - video: Any video data associated with this content.
    ///   - body:  A component builder returning the body for the page.
    init<R: Route>(
        route: R,
        date: Date = Date(),
        lastModified: Date = Date(),
        imagePath: Path? = nil,
        audio: Audio? = nil,
        video: Video? = nil,
        @ComponentBuilder body: () -> Component
    ) {
        self.init(
            path: route.path,
            content: Content(
                title: route.title,
                description: route.description,
                body: Content.Body(components: body),
                date: date,
                lastModified: lastModified,
                imagePath: imagePath,
                audio: audio,
                video: video))
    }
}
