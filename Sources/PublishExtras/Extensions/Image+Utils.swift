//
//  Image+Utils.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 10/27/24.
//  Copyright © 2024 Mobelux. All rights reserved.
//

import Foundation
import Plot

public extension Image {
    /// Creates an instance.
    ///
    /// - Parameter imageAsset: An image asset.
    init(_ imageAsset: ImageAsset) {
        self.init(url: imageAsset.url, description: imageAsset.description ?? "")
    }
}
