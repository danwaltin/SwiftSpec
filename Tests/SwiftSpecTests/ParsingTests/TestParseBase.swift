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
//  TestParseBase.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-03.
//
// ------------------------------------------------------------------------

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

