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
//  TestFileWriter.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-25.
//
// ------------------------------------------------------------------------

import Foundation
import GherkinSwift

let FEATURE_FILE_EXTENSION = "feature"

public protocol TestFileWriter {
	func generateUnitTestsFromFeatureFiles(baseDirectory: String)
}

class TestFileWriterImplementation : TestFileWriter {
	
	private let fileSystem: FileSystem
	private let featureParser: FeatureParser
	private let unitTestGenerator: UnitTestGenerator
	
	init(
		fileSystem: FileSystem,
		featureParser: FeatureParser,
		unitTestGenerator: UnitTestGenerator) {
		self.fileSystem = fileSystem
		self.featureParser = featureParser
		self.unitTestGenerator = unitTestGenerator
	}
	
	func generateUnitTestsFromFeatureFiles(baseDirectory: String) {
		for featureFilePath in featureFiles(baseDirectory) {
			
			let path = unitTestFilePath(featureFilePath: featureFilePath)
			let lines = try! fileSystem.readAllLines(atPath: featureFilePath)
			let result = featureParser.pickle(lines: lines, fileUri: featureFilePath)
			
			let content = unitTestGenerator.generateUnitTest(result: result, fromFeatureFilePath: featureFilePath)
			
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

	private func unitTestFilePath(featureFilePath: String) -> String {
		let firstPart = featureFilePath.stringByDeletingPathExtension()
		let unitTestFileURL = "\(firstPart).feature.swift"
		
		return unitTestFileURL
	}
	
	private func _isFeatureFile(path: String) -> Bool {
		return path.pathExtension() == FEATURE_FILE_EXTENSION
	}

}
