//
//  Website+Utils.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 3/8/24.
//  Copyright © 2024 Mobelux. All rights reserved.
//

import Foundation
import Plot
import Publish

public extension Website {
    /// Publish this website using a default pipeline.
    ///
    /// - Parameters:
    ///   - theme: The HTML theme to generate the website using.
    ///   - indentation: How to indent the generated files.
    ///   - path: Any specific path to generate the website at.
    ///   - preGenerationPlugins: Plugins to be installed at the start of the publishing process.
    ///   - preGenerationSteps: Any additional steps to add to the publishing
    ///   pipeline. Will be executed right before the HTML generation process begins.
    ///   - postGenerationPlugins: Plugins to be installed after
    ///   - postGenerationSteps: Additional steps to add to the pipeline after the HTML generation
    ///   process.
    ///   - rssFeedSections: What sections to include in the site's RSS feed.
    ///   - rssFeedConfig: The configuration to use for the site's RSS feed. A feed will only be
    ///   generated if a configuration is provided.
    ///   - deploymentMethod: How to deploy the website.
    /// - Returns: The published website.
    @discardableResult
    func publish(
        withTheme theme: Theme<Self>,
        indentation: Indentation.Kind? = nil,
        at path: Path? = nil,
        preGenerationPlugins: [Plugin<Self>] = [],
        preGenerationSteps: [PublishingStep<Self>] = [],
        postGenerationPlugins: [Plugin<Self>] = [],
        postGenerationSteps: [PublishingStep<Self>] = [],
        rssFeedSections: Set<SectionID> = Set(SectionID.allCases),
        rssFeedConfig: RSSFeedConfiguration? = nil,
        deployedUsing deploymentMethod: DeploymentMethod<Self>? = nil,
        file: StaticString = #file
    ) throws -> PublishedWebsite<Self> {
        try publish(
            at: path,
            using: [
                .group(preGenerationPlugins.map(PublishingStep.installPlugin)),
                .optional(.copyResources()),
                .addMarkdownFiles(),
                .sortItems(by: \.date, order: .descending),
                .group(preGenerationSteps),
                .generateHTML(withTheme: theme, indentation: indentation),
                .unwrap(rssFeedConfig) { config in
                    .generateRSSFeed(
                        including: rssFeedSections,
                        config: config
                    )
                },
                .generateSiteMap(indentedBy: indentation),
                .group(postGenerationPlugins.map(PublishingStep.installPlugin)),
                .group(postGenerationSteps),
                .unwrap(deploymentMethod, PublishingStep.deploy)
            ],
            file: file
        )
    }
}
