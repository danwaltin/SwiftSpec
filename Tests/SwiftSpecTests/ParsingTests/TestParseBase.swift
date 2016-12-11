//
//  TestParseBase.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-03.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import XCTest
@testable import SwiftSpec

class TestParseBase: XCTestCase {
	var actualFeature: Feature!

	func when_parsingFeature(_ lines: [String]) {
		actualFeature = parser().parse(lines: lines)
	}
	
	func then_shouldReturnScenariosWithTitles(_ titles: [String]) {
		let actualTitles = scenarios().map{s in
			s.title
		}
		XCTAssertEqual(actualTitles, titles)
	}

	func parser() -> GherkinFeatureParser {
		let scanner = FeatureScanner()
		return GherkinFeatureParser(featureScanner: scanner)
	}
	
	func scenarios() -> [Scenario] {
		return actualFeature.scenarios
	}
	
	func scenario(at index: Int) -> Scenario {
		return scenarios()[index]
	}

	// MARK:
	// MARK: Factory methods
	func table(_ col: String,
	           _ r1c1: String) -> Table {
		return Table(columns: [col])
			.addingRow(cells: [r1c1])
	}
	
	func table(_ col: String,
	           _ r1c1: String,
	           _ r2c1: String) -> Table {
		return Table(columns: [col])
			.addingRow(cells: [r1c1])
			.addingRow(cells: [r2c1])
	}
	
	func table(_ c1: String, _ c2: String,
	           _ r1c1: String, _ r1c2: String) -> Table {
		return Table(columns: [c1, c2])
			.addingRow(cells: [r1c1, r1c2])
	}
	
	func table(_ c1: String, _ c2: String,
	           _ r1c1: String, _ r1c2: String,
	           _ r2c1: String, _ r2c2: String) -> Table {
		return Table(columns: [c1, c2])
			.addingRow(cells: [r1c1, r1c2])
			.addingRow(cells: [r2c1, r2c2])
	}
}

