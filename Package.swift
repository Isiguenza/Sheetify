// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Sheetify",
    platforms: [
        .iOS(.v16),
        .macCatalyst(.v16)
    ],
    products: [
        .library(
            name: "Sheetify",
            targets: ["Sheetify"]
        ),
    ],
    dependencies: [
        // Dependency for SwiftUI view inspection in tests
        .package(
            url: "https://github.com/nalexn/ViewInspector.git",
            from: "0.9.0"
        ),
    ],
    targets: [
        .target(
            name: "Sheetify",
            path: "Sources/Sheetify"
        ),
        .testTarget(
            name: "SheetifyTests",
            dependencies: [
                "Sheetify",
                .product(name: "ViewInspector", package: "ViewInspector")
            ]
        ),
    ]
)
