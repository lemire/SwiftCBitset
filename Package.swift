import PackageDescription

let package = Package(
    name: "SwiftCBitset",
    targets: [
        Target(name: "SwiftCBitset", dependencies: ["cbitset"]),
    ],
    dependencies: [
   .Package(url: "https://github.com/lemire/Swimsuit.git",  majorVersion: 0)
    ]
)
