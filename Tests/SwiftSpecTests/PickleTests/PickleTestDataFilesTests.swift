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
		let test = "minimal"
		let goodPath = "testdata/good"

		let testFileContent = content(of: test + ".feature", inDirectory: goodPath)
		let expectedFileContent = content(of: test + ".feature.ast.ndjson", inDirectory: goodPath)

		let lines = testFileContent.lines()

		let f = parser().parse(lines: lines)
		
		let actual = GherkinFile(gherkinDocument: GherkinDocument(feature: f))

		let expected = try! JSONDecoder().decode(GherkinFile.self, from: expectedFileContent)
		
		XCTAssertEqual(actual, expected)
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

extension GherkinFile : Decodable {
	enum CodingKeys: String, CodingKey {
		case gherkinDocument
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let d = try container.decode(GherkinDocument.self, forKey: .gherkinDocument)
		self.init(gherkinDocument: d)
	}
}

extension GherkinDocument : Decodable {
	enum CodingKeys: String, CodingKey {
		case feature
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		let f = try container.decode(Feature.self, forKey: .feature)
		self.init(feature: f)
	}
}

extension Feature : Decodable {
	enum CodingKeys: String, CodingKey {
		case name
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		let n = try container.decode(String.self, forKey: .name)
		self.init(name: n)
	}
}
