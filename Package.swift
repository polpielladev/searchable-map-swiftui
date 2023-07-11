// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SearchableMap",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "SearchableMap",
            targets: ["SearchableMap"]),
    ],
    targets: [
        .target(
            name: "SearchableMap")
    ]
)
