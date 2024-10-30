//
//  Collection+Utils.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 4/27/23.
//  Copyright © 2023 Mobelux. All rights reserved.
//

import Foundation
import enum Publish.SortOrder

public extension Collection {
    /// A Boolean value indicating whether the collection contains elements.
    var isNotEmpty: Bool {
        !isEmpty
    }

    /// Returns two collections by bifurcating the elements of the collection such that all the
    /// elements that match the given predicate are placed in the second collection while those
    /// that don't match are placed in the first.
    ///
    /// This method preserves the relative order of the bifurcated elements.
    ///
    /// In the following example, an array of numbers is bifurcated by a predicate that matches
    /// elements greater than 30.
    ///
    /// ```swift
    /// var numbers = [30, 40, 20, 30, 30, 60, 10]
    /// let (lessThan, greaterThan) = numbers.bifurcated(by: { $0 > 30 })
    /// // lessThan == [30, 20, 30, 30, 10]
    /// // greaterThan == [40, 60]
    /// ```
    ///
    /// - Complexity: O(_n_), where _n_ is the length of the sequence.
    ///
    /// - Parameter belongsInSecondCollection: A predicate used to bifurcate the collection. All
    /// elements satisfying this predicate are placed in the second collection while those that
    /// don't are placed in the first.
    /// - Returns: A tuple containing one collection of elements that don't match the given
    /// predicate and another of those that do.
    func bifurcated(by belongsInSecondCollection: (Self.Element) throws -> Bool) rethrows -> ([Element], [Element]) {
        try reduce(into: ([], [])) { result, item in
            try belongsInSecondCollection(item) ? result.1.append(item) : result.0.append(item)
        }
    }

    /// Returns a collection of evenly divided subsequences of this collection.
    ///
    /// - Parameter chunkCount: The number of chunks to evenly divide this collection into.
    func evenlyChunked(in chunkCount: Int) -> [[Element]] {
        precondition(chunkCount >= 0, "Can't divide into a negative number of chunks")
        precondition(chunkCount > 0 || isEmpty, "Can't divide a non-empty collection into 0 chunks")

        let chunkSize = Int(ceil(Double(count) / Double(chunkCount)))
        var chunks = [[Element]]()
        var startIdx = startIndex

        while startIdx < endIndex {
            let endIdx = index(startIdx, offsetBy: chunkSize, limitedBy: endIndex) ?? endIndex
            chunks.append(Array(self[startIdx..<endIdx]))
            startIdx = endIdx
        }

        return chunks
    }

    /// Returns the elements of the sequence, sorted by the given key path, in the specified order.
    ///
    /// - Parameters:
    ///   - sortingKeyPath: The key path to sort the items by.
    ///   - order: The order to use when sorting the items.
    func sorted<T: Comparable>(
        by sortingKeyPath: KeyPath<Element, T>,
        order: SortOrder = .ascending
    ) -> [Element] {
        sorted(by: order.makeSorter(forKeyPath: sortingKeyPath))
    }
}
