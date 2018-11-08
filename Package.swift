// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "Hex",
    products: [
        .library(name: "Hex", targets: ["Hex"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-stack/test.git",
            .branch("master"))
    ],
    targets: [
        .target(
            name: "Hex",
            dependencies: []),
        .testTarget(
            name: "HexTests",
            dependencies: ["Test", "Hex"]),
    ]
)
