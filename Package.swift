// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "justchat",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "justchat",
            targets: ["justchat"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", branch: "master")
      ],
      targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
          name: "justchat",
          dependencies: [
            .product(name: "FirebaseAnalytics", package: "Firebase"),
            .product(name: "FirebaseAuth", package: "Firebase"),
            .product(name: "FirebaseAppCheck", package: "Firebase"),
            .product(name: "FirebaseCrashlytics", package: "Firebase"),
            .product(name: "FirebaseDatabase", package: "Firebase"),
            .product(name: "FirebaseDynamicLinks", package: "Firebase"),
            .product(name: "FirebaseFirestore", package: "Firebase"),
            .product(name: "FirebaseFunctions", package: "Firebase"),
            .product(name: "FirebaseInstallations", package: "Firebase"),
            .product(name: "FirebaseMessaging", package: "Firebase"),
            .product(name: "FirebaseMLModelDownloader", package: "Firebase"),
            .product(name: "FirebasePerformance", package: "Firebase"),
            .product(name: "FirebaseRemoteConfig", package: "Firebase"),
            .product(name: "FirebaseStorage", package: "Firebase"),
          ]),
        .testTarget(
            name: "justchatTests",
            dependencies: ["justchat"]),
    ]
)
