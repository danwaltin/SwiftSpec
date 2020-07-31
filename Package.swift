// swift-tools-version:5.2
// ------------------------------------------------------------------------
// Copyright 2017 Dan Waltin
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ------------------------------------------------------------------------
//
//  Package.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-12-11.
//
// ------------------------------------------------------------------------

import PackageDescription

let package = Package(
    name: "SwiftSpec",
    products: [
        .library(
            name: "SwiftSpec",
            targets: ["SwiftSpec"]),
		.executable(name: "SwiftSpecConsole", targets: ["SwiftSpecConsole"])
    ],
    dependencies: [
		.package(url: "https://github.com/danwaltin/GherkinSwift", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SwiftSpec",
            dependencies: ["GherkinSwift"]),
        .target(
            name: "SwiftSpecConsole",
            dependencies: ["SwiftSpec"]),
        .testTarget(
            name: "SwiftSpecTests",
            dependencies: ["SwiftSpec"]),
    ]
)
