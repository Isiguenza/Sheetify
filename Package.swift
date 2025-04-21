// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

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
  targets: [
    .target(
      name: "Sheetify",
      path: "Sources/Sheetify"
    ),
    .testTarget(
      name: "SheetifyTests",
      dependencies: ["Sheetify"]
    ),
  ]
)
