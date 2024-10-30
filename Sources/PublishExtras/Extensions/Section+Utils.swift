//
//  Section+Utils.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 6/27/23.
//  Copyright © 2023 Mobelux. All rights reserved.
//

import Foundation
import Publish

public extension Section {
    /// Returns a collection of the section's items with section-specific metadata.
    ///
    /// For a website defined as follows:
    ///
    /// ```swift
    /// struct MyWebsite: Website {
    ///     enum SectionID: String, WebsiteSectionID { case products, recipes }
    ///
    ///     struct ProductInfo: WebsiteItemMetadata { ... }
    ///
    ///     struct RecipeInfo: WebsiteItemMetadata { ... }
    ///
    ///     struct ItemMetadata: WebsiteItemMetadata {
    ///         case product(ProductInfo)
    ///         case recipe(RecipeInfo)
    ///
    ///         var productMetadata: ProductInfo? {
    ///             guard case .product(let metadata) = self else { return nil }
    ///             return metadata
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// where items in the "products" section have `ProductInfo` metadata and those in the "recipes"
    /// section have `RecipeInfo`, use this method to obtain a collection of the "recipes" section's
    /// items expressing their section-specific metadata:
    ///
    /// ```swift
    /// var productsSection: Section<MyWebsite>
    /// ...
    /// let productsItems: [SectionItem<ProductInfo>] = productsSection.sectionItems(\.productMetadata)
    /// ```
    ///
    /// - Parameter transform: A closure transforming site-specific metadata into section-specific
    /// metadata.
    func sectionItems<Metadata: WebsiteItemMetadata>(
        transform: (Site.ItemMetadata) -> Metadata?
    ) -> [SectionItem<Metadata>] {
        items.compactMap { SectionItem($0, transformMetadata: transform) }
    }
}
