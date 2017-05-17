# SwiftSpec

A [Swift][1] package for [BDD][2]/[Specification by example][3] à la [Gherkin][4]. 

## Table of Contents
1. [Setup](#setup)
2. [Usage](#usage)

## Setup

This section describes setup for using SwiftSpec in an XCode 8 project.

1. Download
2. Compile
3. Use in the XCode project

### Download
Download SwiftSpec, eihter by cloning the repository or by downloading a specific [release][5].

### Compile

Compile and archive the framework, either from the SwiftSpec.xcodeproj project, or from command line using  

	xcodebuild -scheme SwiftSpec archive

Build the command line tool, which is used to generate XCTest files from .feature files, using

	swift build

### Use in the XCode project

Export the archived framework, SwiftSpec.framework, which is available in the XCode organizer.

In the test target of your project
1. add a build phase `Link Binary With Frameworks`, and add the SwiftSpec.framework
2. add a build phase `Copy Files`, with destination `Frameworks`, and add the SwiftSpec.framework 

## Usage

1. Write feature files
2. Generate XCTest test files using the SwiftSpec command line tool, found under `.build/debug/SwiftSpecConsole`
3. Add the test files to the XCode project
4. Write bindings
5. Implement the code

[1]: http://swift.org/                                         "Swift"
[2]: https://en.wikipedia.org/wiki/Behavior-driven_development "Behaviour Driven Development"
[3]: https://en.wikipedia.org/wiki/Specification_by_example    "Specification by Example"
[4]: https://github.com/cucumber/cucumber/wiki/Gherkin         "Gherkin"
[5]: https://github.com/danwaltin/SwiftSpec/releases           "SwiftSpec Releases"
