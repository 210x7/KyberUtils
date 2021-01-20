// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "KyberUtils",
  platforms: [
    .iOS(.v14),
    .macOS(.v11)
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "KyberGeo",
      targets: ["KyberGeo"]
    ),
    .library(
      name: "KyberGraphs",
      targets: ["KyberGraphs"]
    ),
    .library(
      name: "KyberSearch",
      targets: ["KyberSearch"]
    ),
    .library(
      name: "KyberCommon",
      targets: ["KyberCommon"]
    ),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.10.0"),
    .package(url: "https://github.com/pointfreeco/composable-core-location", from: "0.1.0")
    //.package(url: "https://github.com/OAuthSwift/OAuthSwift.git", from: "2.1.0"),
    //.package(url: "https://github.com/pichukov/LightChart", from: "1.0.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "KyberGeo",
      dependencies: []
    ),
    .testTarget(
      name: "KyberGeoTests",
      dependencies: ["KyberGeo"]
    ),
    .target(
      name: "KyberGraphs",
      dependencies: [
        //.product(name: "LightChart", package: "LightChart")
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
        .target(name:  "KyberGeo")
      ]
    ),
    .testTarget(
      name: "KyberSearchTests",
      dependencies: [
        "KyberSearch",
        "KyberGeo"
      ]
    ),
    .target(
      name: "KyberCommon",
      dependencies: [
        //.product(name: "LightChart", package: "LightChart")
      ]),
    .testTarget(
      name: "KyberCommonTests",
      dependencies: []
    ),
  ]
)
