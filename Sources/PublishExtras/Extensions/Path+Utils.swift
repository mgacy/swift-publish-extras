//
//  Path+Utils.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 4/27/23.
//  Copyright © 2023 Mobelux. All rights reserved.
//

import struct Publish.Path

public extension Path {
    /// Prepends a path component to the path.
    ///
    /// - Parameter component: The path component to add.
    mutating func prependComponent(_ component: String) {
        guard component.isNotEmpty,
              !string.hasPrefix("http://"),
              !string.hasPrefix("https://")
        else {
            return
        }

        let component = component.drop(while: { $0 == "/" })
        let current = string.drop(while: { $0 == "/" })
        let separator = (component.last == "/" ? "" : "/")
        string = "\(component)\(separator)\(current)"
    }

    /// Returns a path by prepending the specified path component to self.
    /// 
    /// - Parameter component: The path component to add.
    func prependingComponent(_ component: String) -> Path {
        guard component.isNotEmpty,
              !string.hasPrefix("http://"),
              !string.hasPrefix("https://")
        else {
            return self
        }

        let component = component.drop(while: { $0 == "/" })
        let current = string.drop(while: { $0 == "/" })
        let separator = (component.last == "/" ? "" : "/")
        return "\(component)\(separator)\(current)"
    }
}
