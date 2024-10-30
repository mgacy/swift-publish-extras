//
//  GTMConfiguration.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 4/24/24.
//  Copyright © 2024 Mobelux. All rights reserved.
//

import Foundation

/// Configuration for Google Tag Manager (GTM) snippets.
public struct GTMConfiguration: Equatable, Sendable {
    /// The GTM container ID.
    public let containerID: String

    /// The GTM auth token.
    public let authToken: String

    /// The GTM preview environment.
    public let previewEnvironment: Int

    /// Creates an instance.
    ///
    /// - Parameters:
    ///   - containerID: The GTM container ID.
    ///   - authToken: The GTM auth token.
    ///   - previewEnvironment: The GTM preview environment.
    public init(containerID: String, authToken: String, previewEnvironment: Int) {
        self.containerID = containerID
        self.authToken = authToken
        self.previewEnvironment = previewEnvironment
    }
}
