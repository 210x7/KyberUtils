// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "KyberUtils",
  platforms: [
    .iOS(.v14),
    .macOS(.v11),
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(name: "KyberGeo", targets: ["KyberGeo"]),
    .library(name: "KyberGraphs", targets: ["KyberGraphs"]),
    .library(name: "KyberSearch", targets: ["KyberSearch"]),
    .library(name: "KyberCommon", targets: ["KyberCommon"]),
    .library(
      name: "KyberAstro", targets: ["KyberAstro"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.16.0"),
    .package(url: "https://github.com/pointfreeco/composable-core-location", from: "0.1.0"),
    .package(url: "https://github.com/willdale/SwiftUICharts", from: "2.7.0"),
    .package(
      name: "Introspect",
      url: "https://github.com/siteline/SwiftUI-Introspect",
      from: "0.1.3"
    ),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "KyberGeo",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "ComposableCoreLocation", package: "composable-core-location"),
      ]
    ),
    .testTarget(
      name: "KyberGeoTests",
      dependencies: ["KyberGeo"]
    ),
    .target(
      name: "KyberGraphs",
      dependencies: [
        "SwiftUICharts",
        .target(name: "KyberCommon"),
        .target(name: "KyberAstro"),
      ]),
    .testTarget(
      name: "KyberGraphsTests",
      dependencies: ["KyberGraphs"]
    ),
    .target(
      name: "KyberSearch",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "ComposableCoreLocation", package: "composable-core-location"),
        .target(name: "KyberGeo"),
      ]
    ),
    .testTarget(
      name: "KyberSearchTests",
      dependencies: [
        "KyberSearch",
        "KyberGeo",
      ]
    ),
    .target(
      name: "KyberCommon",
      dependencies: [
        "Introspect",
        "KyberGeo",
      ]
    ),
    .testTarget(
      name: "KyberCommonTests",
      dependencies: ["KyberCommon"]
    ),
    .target(
      name: "KyberAstro",
      dependencies: []),
    .testTarget(
      name: "KyberAstroTests",
      dependencies: ["KyberAstro"]
    ),
  ]
)
