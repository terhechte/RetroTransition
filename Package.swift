// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "RetroTransition",
  platforms: [.iOS(.v9),],
  products: [
    .library(
      name: "RetroTransition",
      targets: ["RetroTransition"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "RetroTransition",
      dependencies: []
    ),
  ]
)
