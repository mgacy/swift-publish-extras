//
//  EnvironmentProvider.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 4/28/24.
//  Copyright © 2024 Mobelux. All rights reserved.
//

import Foundation

/// A class of types providing an dictionary of environment variable names and values.
public protocol EnvironmentProvider {
    /// The variable names (keys) and their values in the environment from which the process was
    /// launched.
    var environment: [String: String] { get }
}

extension ProcessInfo: EnvironmentProvider {}
