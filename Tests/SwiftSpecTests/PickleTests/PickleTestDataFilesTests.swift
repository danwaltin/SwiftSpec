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
		return stringContent(of: test + ".feature.ast.ndjson", inDirectory: path)
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
		let testFileContent = stringContent(of: test + ".feature", inDirectory: path)

		let lines = testFileContent.lines()

		let f = parser().parse(lines: lines)
		
		return GherkinFile(gherkinDocument: GherkinDocument(feature: f))
	}
	
	private func stringContent(of file: String, inDirectory directory: String) -> String {
		let testFile = directory + "/" + file
		
		let thisSourceFile = URL(fileURLWithPath: #file)
		let thisDirectory = thisSourceFile.deletingLastPathComponent()
		let directoryAbove = thisDirectory.deletingLastPathComponent()
		
		let testFileURL = directoryAbove.appendingPathComponent(testFile)
		let data = try! Data(contentsOf: testFileURL)
		
		return String(data: data, encoding: .utf8)!
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

