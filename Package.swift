// swift-tools-version:5.1.0

import PackageDescription

let package = Package(
  name: "BitSet",
  targets: [
    .target(
      name: "BitSetLib",
      path: "Sources/BitSet"
    ),
    .testTarget(
      name: "BitSetTests",
      dependencies: ["BitSetLib"])
  ]
)
