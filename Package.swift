// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "swift-weather",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "swift-weather",
            targets: ["swift-weather"]
        )
    ],
    targets: [
        .target(
            name: "swift-weather",
            path: "Sources"
        )
    ]
)
