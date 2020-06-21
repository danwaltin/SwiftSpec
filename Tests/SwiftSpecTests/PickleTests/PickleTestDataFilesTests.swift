//
//  PickleTestDataFilesTests.swift
//  SwiftSpecTests
//
//  Created by Dan Waltin on 2020-06-19.
//

import XCTest
@testable import SwiftSpec
@testable import GherkinSwift

class PickleTestDataFilesTests: XCTestCase {
	let goodTests = ["incomplete_feature_2"]
	func test_goodTestDataFiles() {

		let goodPath = "testdata/good"
		
		for test in goodTests {
			let expected = expectedJson(path: goodPath, test: test)
				.trim()
			
			let actual = parseAndGetJson(path: goodPath, test: test)
				.replacingOccurrences(of: " :", with: ":")
				.trim()
			
			XCTAssertEqual(actual, expected, "Wrong json for '\(test)'")
		}
	}
	
	private func expectedJson(path: String, test: String) -> String {
		return testFileContent(of: filePath(path, test + ".feature.ast.ndjson"))
	}
	
	private func parseAndGetJson(path: String, test: String) -> String {
		let pickledFile = gherkinFile(path: path, test: test)

		return getJson(from: pickledFile)
	}
	
	private func getJson(from pickledFile: GherkinFile) -> String {
		let encoder = JSONEncoder()
		encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
		let actualJson = try! encoder.encode(pickledFile)

		return String(data: actualJson, encoding: .utf8)!
	}
	
	private func gherkinFile(path: String, test: String) -> GherkinFile {
		
		let file = filePath(path, test + ".feature")
		let lines = testFileContent(of: file).lines()

		return parser().pickle(lines: lines, fileUri: file)
	}
	
	private func testFileContent(of file: String) -> String {
		let thisSourceFile = URL(fileURLWithPath: #file)
		let currentDirectory = thisSourceFile.deletingLastPathComponent()
		let parentDirectory = currentDirectory.deletingLastPathComponent()
		
		let testFileURL = parentDirectory.appendingPathComponent(file)
		let data = try! Data(contentsOf: testFileURL)
		
		return String(data: data, encoding: .utf8)!
	}

	private func filePath(_ folder: String, _ file: String) -> String {
		return folder + "/" + file
	}
	
	private func parser() -> GherkinFeatureParser {
		let scanner = FeatureScanner()
		return GherkinFeatureParser(featureScanner: scanner)
	}
}

extension String {
	func lines() -> [String] {
		return components(separatedBy: "\n")
	}
}

