// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChessStorage",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ChessStorage",
            targets: ["ChessStorage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stephencelis/SQLite.swift", .upToNextMajor(from: "0.15.3"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ChessStorage",
            dependencies: [
                .product(name: "SQLite", package: "SQLite.swift")
            ]
        ),
        .testTarget(
            name: "ChessStorageTests",
            dependencies: ["ChessStorage"]
        ),
    ]
)
