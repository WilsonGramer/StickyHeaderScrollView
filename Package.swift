// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "StickyHeaderScrollView",
    platforms: [.iOS("14.0")],
    products: [
        .library(
            name: "StickyHeaderScrollView",
            targets: ["StickyHeaderScrollView"]
        ),
    ],
    targets: [
        .target(
            name: "StickyHeaderScrollView",
            path: "Sources"
        ),
    ]
)
