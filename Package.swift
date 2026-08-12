// swift-tools-version:6.1.0

import PackageDescription
import Foundation

let package = Package(
    name: "combine-schedulers",
    platforms: [
        .iOS("13.0"),
        .macOS("10.15"),
        .tvOS("13.0"),
        .watchOS("6.0")
    ],
    products: [
        .library(
            name: "CombineSchedulers",
            targets: ["CombineSchedulers", "CombineSchedulers_PrecompiledProduct"]
        )
    ],
    traits: [
        .trait(
            name: "OpenCombineSchedulers",
            description: "Support for Combine on non-Apple platforms using OpenCombine."
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-precompiled/swift-concurrency-extras",
            exact: "1.4.1"
        ),
        .package(
            url: "https://github.com/swift-precompiled/xctest-dynamic-overlay",
            exact: "1.11.0"
        )
    ],
    targets: [
        .target(
            name: "CombineSchedulers_Aggregation",
            dependencies: ["CombineSchedulers"],
            swiftSettings: [.define("SCIPIO_PRECOMPILED_BINARY_WRAPPER")]
        ),
        .binaryTarget(
            name: "CombineSchedulers",
            url: "https://github.com/swift-precompiled/combine-schedulers/releases/download/1.2.0/CombineSchedulers-bf6d7715b4680f102ab1c1ebfda645240c46cfb6542f2719dba665a1c96a9ab3.xcframework.zip",
            checksum: "bf6d7715b4680f102ab1c1ebfda645240c46cfb6542f2719dba665a1c96a9ab3"
        ),
        .target(
            name: "CombineSchedulers_PrecompiledProduct",
            dependencies: [
                "CombineSchedulers_Aggregation",
                .product(
                    name: "ConcurrencyExtras",
                    package: "swift-concurrency-extras"
                ),
                .product(
                    name: "IssueReporting",
                    package: "xctest-dynamic-overlay"
                )
            ]
        )
    ]
)