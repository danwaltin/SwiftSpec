# SwiftSpec

A [Swift][1] package for [BDD][2]/[Specification by example][3] à la [Gherkin][4]. 

## Limitations
Does not (yet) handle
* Backgound
* DocStrings

## Table of Contents
1. [Setup](#setup)
2. [Usage](#usage)

## Setup

This section describes setup for using SwiftSpec in an Xcode 11 project.

1. Download and Compile
3. Use in the Xcode project

### Download and Compile
Download SwiftSpec, either by cloning the repository or by downloading a specific [release][5].

Build the command line tool, which is used to generate XCTest files from .feature files, using

	swift build

### Use in the Xcode project

Add SwiftSpec as a Package Manager dependency in Xcode.

## Usage

1. Write feature files
2. Generate (or update) XCTest test files using the SwiftSpec command line tool, found under `.build/debug/SwiftSpecConsole`
3. Add the test files to the Xcode project
4. Write bindings
5. Implement the code

[1]: http://swift.org/                                         "Swift"
[2]: https://en.wikipedia.org/wiki/Behavior-driven_development "Behaviour Driven Development"
[3]: https://en.wikipedia.org/wiki/Specification_by_example    "Specification by Example"
[4]: https://github.com/cucumber/cucumber/wiki/Gherkin         "Gherkin"
[5]: https://github.com/danwaltin/SwiftSpec/releases           "SwiftSpec Releases"
