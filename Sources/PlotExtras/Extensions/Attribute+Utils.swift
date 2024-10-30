//
//  Attribute+Utils.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 4/11/24.
//  Copyright © 2024 Mobelux. All rights reserved.
//

import Foundation
import Plot

public extension Attribute where Context: HTMLSourceContext {
    /// Assigns a media query to this source.
    ///
    /// - Parameter query: The media query.
    static func media(_ query: String) -> Attribute {
        Attribute(name: "media", value: query)
    }
}

public extension Attribute where Context == HTML.ObjectContext {
    /// Assigns a string describing the MIME type, using the `type` attribute.
    ///
    /// - Parameter type: The type (MIME type) for this element.
    static func type(_ type: String) -> Attribute {
        Attribute(name: "type", value: type)
    }
}
