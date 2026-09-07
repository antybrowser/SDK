// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AntybrowserSDK",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(name: "AntybrowserSDK", targets: ["AntybrowserSDK"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AntybrowserSDK",
            dependencies: [],
            path: "Sources"
        ),
    ]
)
