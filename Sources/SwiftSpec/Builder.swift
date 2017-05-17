//
//  Builder.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2017-05-17.
//
//

import Foundation

public struct XBuilder {
	public init() {
		
	}
	
	public func buildTestFileWriter() -> TestFileWriter {
		let writer = TestFileWriterImplementation(
		 	fileSystem: CocoaFileSystem(),
		 	featureParser: GherkinFeatureParser(featureScanner: FeatureScanner()),
		 	unitTestGenerator: XCUnitTestGenerator())

		return writer
	}
}
