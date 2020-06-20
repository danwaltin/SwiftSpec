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
	func test_goodTestDataFiles() {
		let test = "incomplete_feature_2"
		let goodPath = "testdata/good"

		let testFileContent = content(of: test + ".feature", inDirectory: goodPath)
		let expectedJson = content(of: test + ".feature.ast.ndjson", inDirectory: goodPath)

		let lines = testFileContent.lines()

		let f = parser().parse(lines: lines)
		
		let actual = GherkinFile(gherkinDocument: GherkinDocument(feature: f))

		var encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		let actualJson = try! encoder.encode(actual)
		
		let expectedJsonString = String(data: expectedJson, encoding: .utf8)
		let actualJsonString = String(data: actualJson, encoding: .utf8)?.replacingOccurrences(of: " :", with: ":")

		XCTAssertEqual(actualJsonString, expectedJsonString)
	}
	
	private func content(of file: String, inDirectory directory: String) -> Data {
		let testFile = directory + "/" + file
		
		let thisSourceFile = URL(fileURLWithPath: #file)
		let thisDirectory = thisSourceFile.deletingLastPathComponent()
		let directoryAbove = thisDirectory.deletingLastPathComponent()
		
		let testFileURL = directoryAbove.appendingPathComponent(testFile)
		return try! Data(contentsOf: testFileURL)
	}
	
	private func parser() -> GherkinFeatureParser {
		let scanner = FeatureScanner()
		return GherkinFeatureParser(featureScanner: scanner)
	}
}

extension Data {
	func lines() -> [String] {
		let s = String(data: self, encoding: .utf8)!
		return s.components(separatedBy: "\n")
	}
}

extension GherkinFile : Encodable {
	enum CodingKeys: String, CodingKey {
		case gherkinDocument
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(gherkinDocument, forKey: .gherkinDocument)
	}
}

extension GherkinDocument : Encodable {
	enum CodingKeys: String, CodingKey {
		case feature
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(feature, forKey: .feature)
	}
}

extension Feature : Encodable {
	enum CodingKeys: String, CodingKey {
		case name
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(name, forKey: .name)
	}
}
