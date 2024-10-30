// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableExperimentalFeature("StrictConcurrency"),
    .enableUpcomingFeature("InferSendableFromCaptures")
]

let package = Package(
    name: "PublishExtras",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "PublishExtras", targets: ["PublishExtras"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.9.0")
    ],
    targets: [
        .target(
            name: "PublishExtras",
            dependencies: [
                .product(name: "Publish", package: "publish")
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "PublishExtrasTests",
            dependencies: [
                "PublishExtras"
            ]
        )
    ]
)
