//
//  Optional+Utils.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 4/27/24.
//  Copyright © 2024 Mobelux. All rights reserved.
//

import Foundation

public extension Optional {
    /// Convienence method to `throw` if an optional type has a `nil` value.
    ///
    /// - Parameter error: The error to throw.
    /// - Returns: The unwrapped value.
    func unwrap(or error: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .some(let wrapped): wrapped
        case .none: throw error()
        }
    }
}
