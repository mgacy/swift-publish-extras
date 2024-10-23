//
//  HTMLProvider.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 4/27/23.
//  Copyright © 2023 Mobelux. All rights reserved.
//

import Plot
import Publish

/// A type used to generate the HTML that is shared across a website's different locations.
public struct HTMLProvider<Site: Website> {
    let provider: @Sendable (Location, PublishingContext<Site>, [Script], @escaping () -> Component) -> HTML

    /// Creates an HTML provider.
    /// - Parameter provider: A closure that returns HTML for the given location and context.
    public init(
        provider: @escaping @Sendable (Location, PublishingContext<Site>, [Script], @escaping () -> Component) -> HTML
    ) {
        self.provider = provider
    }

    /// Create the HTML for a given location and context.
    /// - Parameters:
    ///   - location: The location to generate HTML for.
    ///   - context:  The current publishing context.
    ///   - scripts: Scripts to add to the HTML.
    ///   - body: A component builder returning the location-specific components.
    public func html(
        for location: Location,
        context: PublishingContext<Site>,
        scripts: [Script] = [],
        @ComponentBuilder body: @escaping () -> Component
    ) -> HTML {
        provider(location, context, scripts, body)
    }
}
