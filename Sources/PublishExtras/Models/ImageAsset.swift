//
//  ImageAsset.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 10/27/24.
//  Copyright © 2024 Mobelux. All rights reserved.
//

import Foundation
import Plot

/// A representation of an image asset.
///
/// Use this type to define images independently of their usage in a specific page or section.
public struct ImageAsset {
    /// The URL of the image.
    public let url: URLRepresentable

    /// The alternative text describing the image.
    public let description: String?

    /// Creates an instance.
    ///
    /// - Parameters:
    ///   - url: The URL of the image.
    ///   - description: The alternative text describing the image.
    public init(_ url: URLRepresentable, description: String? = nil) {
        self.url = url
        self.description = description
    }
}
