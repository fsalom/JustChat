// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JustChat",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "JustChat",
            targets: ["JustChat"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", branch: "master")
      ],
      targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
          name: "JustChat",
          dependencies: [
            .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
            .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
            .product(name: "FirebaseAppCheck", package: "firebase-ios-sdk"),
            .product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk"),
            .product(name: "FirebaseDatabase", package: "firebase-ios-sdk"),
            .product(name: "FirebaseDynamicLinks", package: "firebase-ios-sdk"),
            .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
            .product(name: "FirebaseFunctions", package: "firebase-ios-sdk"),
            .product(name: "FirebaseInstallations", package: "firebase-ios-sdk"),
            .product(name: "FirebaseMessaging", package: "firebase-ios-sdk"),
            .product(name: "FirebaseMLModelDownloader", package: "firebase-ios-sdk"),
            .product(name: "FirebasePerformance", package: "firebase-ios-sdk"),
            .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
            .product(name: "FirebaseStorage", package: "firebase-ios-sdk"),
          ]),
        .testTarget(
            name: "JustChatTests",
            dependencies: ["JustChat"]),
    ]
)
