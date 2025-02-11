// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "google-cloud-kit",
    platforms: [ .macOS(.v10_15)],
    products: [
        .library(
            name: "GoogleCloudKit",
            targets: ["Core", "Storage", "Datastore", "SecretManager"]
        ),
        .library(
            name: "GoogleCloudCore",
            targets: ["Core"]
        ),
        .library(
            name: "GoogleCloudStorage",
            targets: ["Storage"]
        ),
        .library(
            name: "GoogleCloudDatastore",
            targets: ["Datastore"]
        ),
        .library(
            name: "GoogleCloudSecretManager",
            targets: ["SecretManager"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.2.0"),
        .package(url: "https://github.com/vapor/jwt-kit.git", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                .product(name: "JWTKit", package: "jwt-kit"),
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
            ],
            path: "Core/Sources/"
        ),
        .target(
            name: "Storage",
            dependencies: [
                .target(name: "Core")
            ],
            path: "Storage/Sources/"
        ),
        .target(
            name: "Datastore",
            dependencies: [
                .target(name: "Core")
            ],
            path: "Datastore/Sources/"
        ),
        .target(
            name: "SecretManager",
            dependencies: [
                .target(name: "Core")
            ],
            path: "SecretManager/Sources"
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: [
                .target(name: "Core"),
                .product(name: "AsyncHTTPClient", package: "async-http-client")
            ],
            path: "Core/Tests/"
        ),
        .testTarget(
            name: "StorageTests",
            dependencies: [
                .target(name: "Storage")
            ],
            path: "Storage/Tests/"
        ),
        .testTarget(
            name: "DatastoreTests",
            dependencies: [
                .target(name: "Datastore")
            ],
            path: "Datastore/Tests/"
        ),
    ]
)
