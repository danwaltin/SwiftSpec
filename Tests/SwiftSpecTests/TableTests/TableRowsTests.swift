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
//  TableRowsTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-29.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
@testable import GherkinSwift

class TableRowsTests : XCTestCase {
	// MARK: - Adding row with values
	func test_oneColumn_addOneRowWithValue() {
		let table = Table(columns: ["Column"])
			.addingRow(cells: ["rowValue"])
		
		XCTAssertEqual(table.rows.count, 1)
		XCTAssertEqual(table.columns.count, 1)

		XCTAssertEqual(table.rows[0]["Column"], "rowValue")
	}

	func test_twoColumns_addOneRowWithValues() {
		let table = Table(columns: ["c1", "c2"])
			.addingRow(cells: ["v1", "v2"])
		
		XCTAssertEqual(table.rows.count, 1)
		XCTAssertEqual(table.columns.count, 2)

		XCTAssertEqual(table.rows[0]["c1"], "v1")
		XCTAssertEqual(table.rows[0]["c2"], "v2")
	}

	func test_oneColumns_addTwoRowsWithValue() {
		let table = Table(columns: ["c"])
			.addingRow(cells: ["v1"])
			.addingRow(cells: ["v2"])
		
		XCTAssertEqual(table.rows.count, 2)
		XCTAssertEqual(table.columns.count, 1)

		XCTAssertEqual(table.rows[0]["c"], "v1")
		XCTAssertEqual(table.rows[1]["c"], "v2")
	}

	func test_twoColumns_addTwoRowsWithValues() {
		let table = Table(columns: ["c1", "c2"])
			.addingRow(cells: ["r1c1", "r1c2"])
			.addingRow(cells: ["r2c1", "r2c2"])
		
		XCTAssertEqual(table.rows.count, 2)
		XCTAssertEqual(table.columns.count, 2)

		XCTAssertEqual(table.rows[0]["c1"], "r1c1")
		XCTAssertEqual(table.rows[0]["c2"], "r1c2")
		XCTAssertEqual(table.rows[1]["c1"], "r2c1")
		XCTAssertEqual(table.rows[1]["c2"], "r2c2")
	}
	
	// MARK: - Adding row as key/value-pairs
	func test_oneColumnOneRow_addOneRowWithKeyValue() {
		let table = Table(columns: ["Column"])
			.addingRow(cells: ["Column": "rowValue"])
		
		XCTAssertEqual(table.rows.count, 1)
		XCTAssertEqual(table.columns.count, 1)

		XCTAssertEqual(table.rows[0]["Column"], "rowValue")
	}


	func test_twoColumns_addOneRowWithKeyValues() {
		let table = Table(columns: ["c1", "c2"])
			.addingRow(cells: ["c1": "v1", "c2":"v2"])
		
		XCTAssertEqual(table.rows.count, 1)
		XCTAssertEqual(table.columns.count, 2)

		XCTAssertEqual(table.rows[0]["c1"], "v1")
		XCTAssertEqual(table.rows[0]["c2"], "v2")
	}

	func test_oneColumn_addTwoRowsWithKeyValues() {
		let table = Table(columns: ["c"])
			.addingRow(cells: ["c": "v1"])
			.addingRow(cells: ["c": "v2"])
		
		XCTAssertEqual(table.rows[0]["c"], "v1")
		XCTAssertEqual(table.rows[1]["c"], "v2")
	}

	func test_twoColumns_addTwoRowsWithKeyValues() {
		let table = Table(columns: ["c1", "c2"])
			.addingRow(cells: ["c1": "r1c1", "c2": "r1c2"])
			.addingRow(cells: ["c1": "r2c1", "c2": "r2c2"])
		
		XCTAssertEqual(table.rows.count, 2)
		XCTAssertEqual(table.columns.count, 2)
		
		XCTAssertEqual(table.rows[0]["c1"], "r1c1")
		XCTAssertEqual(table.rows[0]["c2"], "r1c2")
		XCTAssertEqual(table.rows[1]["c1"], "r2c1")
		XCTAssertEqual(table.rows[1]["c2"], "r2c2")
	}
}
