import PackageDescription

let package = Package(
    name: "SwiftSpec",
    targets: [
      Target(name: "SwiftSpec"),
      Target(name: "SwiftSpecConsole", dependencies: ["SwiftSpec"])]
)
