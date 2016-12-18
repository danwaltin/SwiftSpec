//
//  main.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-12-17.
//
//

import Foundation

let writer = TestFileWriter(
	fileSystem: CocoaFileSystem(),
	featureParser: GherkinFeatureParser(featureScanner: FeatureScanner()),
	unitTestGenerator: XCUnitTestGenerator())

let path = CommandLine.arguments[1]

writer.generateUnitTestsFromFeatureFiles(baseDirectory: path, timestamp: Date())
