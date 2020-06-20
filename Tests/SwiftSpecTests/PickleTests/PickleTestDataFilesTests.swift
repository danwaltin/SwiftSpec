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

		let expectedJsonString = expectedJson(path: goodPath, test: test)
		let actualJsonString = parseAndGetJson(path: goodPath, test: test)

		XCTAssertEqual(actualJsonString, expectedJsonString)
	}
	
	private func expectedJson(path: String, test: String) -> String {
		return stringContent(of: test + ".feature.ast.ndjson", inDirectory: path).trim()
	}
	
	private func parseAndGetJson(path: String, test: String) -> String {
		let pickledFile = gherkinFile(path: path, test: test)

		let actualJsonString = getJson(from: pickledFile)
		
		return actualJsonString.replacingOccurrences(of: " :", with: ":").trim()
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
		case uri
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(feature, forKey: .feature)
		let path = "testdata/good/incomplete_feature_2.feature"
		try container.encode("\(path)", forKey: .uri)
	}
}

extension Feature : Encodable {
	enum CodingKeys: String, CodingKey {
		case keyword
		case language
		case location
		case name
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode("Feature", forKey: .keyword)
		try container.encode("en", forKey: .language)
		try container.encode(location, forKey: .location)
		try container.encode(name, forKey: .name)
	}
}
