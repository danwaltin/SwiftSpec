//
//  TestFileWriter.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-25.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import Foundation

let FEATURE_FILE_EXTENSION = "feature"

public class TestFileWriter {
	
	private let fileSystem: FileSystem
	private let featureParser: FeatureParser
	private let unitTestGenerator: UnitTestGenerator
	
	internal init(
		fileSystem: FileSystem,
		featureParser: FeatureParser,
		unitTestGenerator: UnitTestGenerator) {
		self.fileSystem = fileSystem
		self.featureParser = featureParser
		self.unitTestGenerator = unitTestGenerator
	}
	
	public func generateUnitTestsFromFeatureFiles(baseDirectory: String, timestamp: Date) {
		for featureFile in featureFiles(baseDirectory) {
			
			let path = unitTestFileName(featureFile: featureFile)
			let lines = try! fileSystem.readAllLines(atPath: featureFile)
			let feature = featureParser.parse(lines: lines)
			let content = unitTestGenerator.generateUnitTest(feature: feature, timestamp: timestamp)
			
			try! fileSystem.writeFile(
				path: path,
				content: content)
		}
	}

	private func featureFiles(_ baseDirectory: String) -> [String] {
		var files: [String] = []
		
		for subpath in try! fileSystem.subpathsOfDirectory(atPath: baseDirectory) {
			
			if _isFeatureFile(path: subpath) {
				let subPathUrl = NSString.path(withComponents: [baseDirectory, subpath])
				files.append(subPathUrl)
			}
		}
		
		return files
	}

	private func unitTestFileName(featureFile: String) -> String {
		let firstPart = featureFile.stringByDeletingPathExtension()
		let unitTestFileURL = "\(firstPart)Tests.swift"
		
		return unitTestFileURL
	}
	
	private func _isFeatureFile(path: String) -> Bool {
		return path.pathExtension() == FEATURE_FILE_EXTENSION
	}

}
