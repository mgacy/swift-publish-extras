//
//  PublishingContext+Utils.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 4/24/23.
//  Copyright © 2023 Mobelux. All rights reserved.
//

import Publish

public extension PublishingContext {
    /// Returns all items within this website that match the given criteria, sorted by a given key path.
    ///
    /// - Parameters:
    ///   - isIncluded: The criteria to filter the items by.
    ///   - sortingKeyPath: The key path to sort the items by.
    ///   - order: The order to use when sorting the items.
    func items<T: Comparable>(
        where isIncluded: (Item<Site>) -> Bool,
        sortedBy sortingKeyPath: KeyPath<Item<Site>, T>,
        order: SortOrder = .ascending
    ) -> [Item<Site>] {
        sections
            .flatMap { $0.items }
            .filter(isIncluded)
            .sorted(
                by: order.makeSorter(forKeyPath: sortingKeyPath)
            )
    }

    /// Returns a collection of items from the given section with section-specific metadata.
    ///
    /// - Parameters:
    ///   - section: The sections from which items should be returned.
    ///   - transform: A closure transforming site-specific metadata into section-specific metadata.
    func sectionItems<Metadata: WebsiteItemMetadata>(
        from section: Site.SectionID,
        transform: (Site.ItemMetadata) -> Metadata?
    ) -> [SectionItem<Metadata>] {
        sections[section].sectionItems(transform: transform)
    }
}
