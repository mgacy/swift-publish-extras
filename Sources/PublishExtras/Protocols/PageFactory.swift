//
//  PageFactory.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 6/22/23.
//  Copyright © 2023 Mobelux. All rights reserved.
//

import Foundation
import Publish

/// A class of types capable of creating pages for a given class of routes.
public protocol PageFactory<Site, PageRoute> {
    associatedtype Site: Website

    /// The class of routes for which the factory creates pages.
    associatedtype PageRoute: Route

    /// Returns the page for the given route.
    ///
    /// - Parameters:
    ///   - route: The route for the page.
    ///   - context: The current publishing context.
    /// - Returns: The route's page.
    func makePage(for route: PageRoute, context: PublishingContext<Site>) throws -> Page
}

// MARK: - PublishingStep+PageFactory

public extension PublishingStep {
    /// Add pages created for the given routes using the given page factory.
    ///
    /// - Parameters:
    ///   - routes: The routes for which pages should be created.
    ///   - factory: The page factory to use to create the pages.
    static func addPages<R: Route, F: PageFactory>(
        for routes: [R],
        using factory: F
    ) -> Self where F.Site == Site, F.PageRoute == R {
        .step(named: "Add Pages for Routes") { context in
            try routes.forEach {
                context.addPage(try factory.makePage(for: $0, context: context))
            }
        }
    }

    /// Add pages created for the given routes using the given page factory.
    ///
    /// - Parameters:
    ///   - routes: The route type for which pages should be created.
    ///   - factory: The page factory to use to create the pages.
    static func addPages<R: Route, F: PageFactory>(
        for route: R.Type,
        using factory: F
    ) -> Self where F.Site == Site, F.PageRoute == R, R: CaseIterable {
        .step(named: "Add Pages for Routes") { context in
            try route.allCases.forEach {
                context.addPage(try factory.makePage(for: $0, context: context))
            }
        }
    }
}
