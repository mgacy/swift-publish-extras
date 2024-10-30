// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PublishExtras",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "PlotExtras", targets: ["PlotExtras"]),
        .library(name: "PublishExtras", targets: ["PublishExtras"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/plot.git", from: "0.9.0"),
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.9.0")
    ],
    targets: [
        .target(
            name: "PlotExtras",
            dependencies: [
                .product(name: "Plot", package: "plot")
            ]
        ),
        .target(
            name: "PublishExtras",
            dependencies: [
                "PlotExtras",
                .product(name: "Publish", package: "publish")
            ]
        ),
        .testTarget(
            name: "PublishExtrasTests",
            dependencies: [
                "PublishExtras"
            ]
        )
    ]
)

for target in package.targets where target.type != .system && target.type != .test {
    target.swiftSettings = target.swiftSettings ?? []
    target.swiftSettings?.append(contentsOf: [
        .enableExperimentalFeature("StrictConcurrency"),
        .enableUpcomingFeature("InferSendableFromCaptures")
    ])
}
