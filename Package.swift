// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "WebstoryzPackage",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "WebstoryzPackage",
            targets: ["WebstoryzPackage"]),
    ],
    dependencies: [
            .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.1"))
        ],
    targets: [
        .target(name: "WebstoryzPackage", dependencies: [
            .target(name: "Alamofire")
        ],
        path: "WebstoryzSDK"),
    ]
)
