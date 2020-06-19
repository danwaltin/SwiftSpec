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
//  TableEqualityTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-29.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
import GherkinSwift

class TableEqualityTests : XCTestCase {
	func test_equalWhenTwoColumns() {
		let one = Table(columns: ["alpha", "beta"])
		let two = Table(columns: ["alpha", "beta"])
		
		XCTAssertEqual(one, two)
	}
	
	func test_notEqualWhenTwoColumns() {
		let one = Table(columns: ["alpha", "beta"])
		let two = Table(columns: ["alpha", "gamma"])
		
		XCTAssertNotEqual(one, two)
	}
	
	func test_equalWhenTwoRows() {
		let one = Table(columns: ["column"])
			.addingRow(cells: ["alpha"])
			.addingRow(cells: ["beta"])
		
		let two = Table(columns: ["column"])
			.addingRow(cells: ["alpha"])
			.addingRow(cells: ["beta"])
		
		XCTAssertEqual(one, two)
	}
	
	func test_notEqualWhenTwoRows_differentColumnNames() {
		let one = Table(columns: ["column"])
			.addingRow(cells: ["alpha"])
			.addingRow(cells: ["beta"])
		
		let two = Table(columns: ["another column"])
			.addingRow(cells: ["alpha"])
			.addingRow(cells: ["beta"])
		
		XCTAssertNotEqual(one, two)
	}
	
	func test_notEqualWhenTwoRows_differentRowValuesSecondRow() {
		let one = Table(columns: ["column"])
			.addingRow(cells: ["alpha"])
			.addingRow(cells: ["beta"])
		
		let two = Table(columns: ["column"])
			.addingRow(cells: ["alpha"])
			.addingRow(cells: ["gamma"])
		
		XCTAssertNotEqual(one, two)
	}
}
