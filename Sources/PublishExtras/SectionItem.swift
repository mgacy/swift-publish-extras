//
//  SectionItem.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 6/27/23.
//  Copyright © 2023 Mobelux. All rights reserved.
//

import Foundation
import Publish

/// A section item represents a website page that is contained within a `Section` and possesses
/// section-specific metadata. It is a specialization of `Publish.Item<Site>`.
///
/// See <doc: SectionMetadata> for more info.
public struct SectionItem<Metadata: WebsiteItemMetadata>: AnyItem {
    /// The item's section-specific metadata.
    public let metadata: Metadata

    /// The item's tags. Items tagged with the same tag can be queried using either `Section` or
    /// `PublishingContext`.
    public let tags: [Tag]

    /// The location's main content. You can also access this type's nested properties as top-level
    /// properties on the location itself, so `title`, rather than `content.title`.
    public var content: Content

    /// Properties that can be used to customize how an item is presented within an RSS feed. See
    /// `ItemRSSProperties`.
    public var rssProperties: ItemRSSProperties

    /// The absolute path of the location within the website, excluding its base URL. For example,
    /// an item "article" contained within a section "mySection" will have the path
    /// "mySection/article". You can resolve the absolute URL for a location and/or path using your
    /// `Website`.
    public let path: Path

    /// The title for the item's representation within an RSS feed.
    public var rssTitle: String {
        let prefix = rssProperties.titlePrefix ?? ""
        let suffix = rssProperties.titleSuffix ?? ""
        return prefix + title + suffix
    }

    public init(metadata: Metadata, tags: [Tag], content: Content, rssProperties: ItemRSSProperties, path: Path) {
        self.metadata = metadata
        self.tags = tags
        self.content = content
        self.rssProperties = rssProperties
        self.path = path
    }
}

public extension SectionItem {
    init<Site: Website>(_ item: Item<Site>, metadata: Metadata) {
        self.metadata = metadata
        self.tags = item.tags
        self.content = item.content
        self.rssProperties = item.rssProperties
        self.path = item.path
    }

    init?<Site: Website>(_ item: Item<Site>, transformMetadata: (Site.ItemMetadata) -> Metadata?) {
        guard let metadata = transformMetadata(item.metadata) else {
            return nil
        }

        self.metadata = metadata
        self.tags = item.tags
        self.content = item.content
        self.rssProperties = item.rssProperties
        self.path = item.path
    }
}

extension SectionItem: Equatable where Metadata: Equatable {}
