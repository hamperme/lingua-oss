// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "LinguaOSS",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(name: "LinguaCore", targets: ["LinguaCore"]),
        .executable(name: "lingua-eval", targets: ["LinguaEvalCLI"])
    ],
    targets: [
        .target(name: "LinguaCore"),
        .executableTarget(
            name: "LinguaEvalCLI",
            dependencies: ["LinguaCore"]
        ),
        .testTarget(
            name: "LinguaCoreTests",
            dependencies: ["LinguaCore"]
        )
    ]
)
