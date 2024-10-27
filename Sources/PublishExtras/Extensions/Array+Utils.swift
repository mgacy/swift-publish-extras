//
//  Array+Utils.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 4/29/23.
//  Copyright © 2023 Mobelux. All rights reserved.
//

import Foundation

public extension Array {
    /// Returns a two-dimensional array containing the array's elements split into chucks of the given size.
    ///
    /// - Parameter size: The size of the chunks.
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
