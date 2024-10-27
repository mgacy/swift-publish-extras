//
//  Node+Script.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 4/27/23.
//  Copyright © 2023 Mobelux. All rights reserved.
//

import Plot
import PlotExtras
import Publish

// MARK: - Scripts

public extension Node where Context == HTML.ScriptContext {
    /// Assigns the `type` of the element's script.
    static func type(_ type: Script.ScriptType) -> Node {
        .attribute(type)
    }
}

public extension Node where Context == HTML.BodyContext {
    /// Adds a `<script>` HTML element with the given representation.
    ///
    /// Usage:
    ///
    /// ```swift
    /// struct Wrapper: Component {
    ///     @ComponentBuilder var content: ContentProvider
    ///     var scriptPath: Path
    ///
    ///     var body: Component {
    ///         Div {
    ///             content()
    ///             Node.script(.immediate(scriptPath))
    ///         }
    ///         .class("wrapper")
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter script: The script's representation.
    static func script(_ script: Script) -> Node {
        script.node()
    }
}

// MARK: - Document

public extension Node where Context == HTML.DocumentContext {
    /// Adds an HTML `<head>` tag within the current context, based on inferred information from the
    /// current location and `Website` implementation.
    ///
    /// - Parameters:
    ///   - location: The location to generate a `<head>` tag for.
    ///   - site: The website on which the location is located.
    ///   - titleSeparator: Any string to use to separate the location's title from the name of the
    ///   website. Default: `" | "`.
    ///   - stylesheetPaths: The paths to any stylesheets to add to the resulting HTML page.
    ///   Default: `styles.css`.
    ///   - scripts: Script elements to add to the resulting HTML page.
    ///   - rssFeedPath: The path to any RSS feed to associate with the resulting HTML page.
    ///   Default: `feed.rss`.
    ///   - rssFeedTitle: An optional title for the page's RSS feed.
    static func head<T: Website>(
        for location: Location,
        on site: T,
        titleSeparator: String = " | ",
        stylesheetPaths: [Path] = ["/styles.css"],
        scripts: [Script] = [],
        rssFeedPath: Path? = .defaultForRSSFeed,
        rssFeedTitle: String? = nil
    ) -> Node {
        var title = location.title

        if title.isEmpty {
            title = site.name
        } else {
            title.append(titleSeparator + site.name)
        }

        var description = location.description

        if description.isEmpty {
            description = site.description
        }

        return .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: location)),
            .title(title),
            .description(description),
            .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
            .forEach(stylesheetPaths, { .stylesheet($0) }),
            .forEach(scripts, { $0.node() }),
            .viewport(.accordingToDevice),
            .unwrap(site.favicon, { .favicon($0) }),
            .unwrap(rssFeedPath, { path in
                let title = rssFeedTitle ?? "Subscribe to \(site.name)"
                return .rssFeedLink(path.absoluteString, title: title)
            }),
            .unwrap(location.imagePath ?? site.imagePath, { path in
                let url = site.url(for: path)
                return .socialImageLink(url)
            })
        )
    }
}

// MARK: - Analytics

public extension Node where Context == HTML.BodyContext {
    /// Returns a `Node` containing the Google Tag Manager script for the `<body>` of a document.
    ///
    /// - Parameter configuration: The configuration for Google Tag Manager.
    /// - Returns: The `Node` containing the GTM script.
    static func gtmBodySnippet(_ configuration: GTMConfiguration) -> Node<HTML.BodyContext> {
        Node.noscript(
            .iframe(
                // swiftlint:disable:next line_length
                .src("https://www.googletagmanager.com/ns.html?id=\(configuration.containerID)&gtm_auth=\(configuration.authToken)&gtm_preview=env-\(configuration.previewEnvironment)&gtm_cookies_win=x"),
                .attribute(named: "height", value: "0"),
                .attribute(named: "width", value: "0"),
                .attribute(named: "style", value: "display:none;visibility:hidden")
            ))
    }
}
