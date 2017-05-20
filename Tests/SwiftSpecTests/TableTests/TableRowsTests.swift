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

class TableRowsTests : XCTestCase {
	func test_oneColumnOneRow() {
		let table = Table(columns: ["Column"])
			.addingRow(cells: ["rowValue"])
		
		XCTAssertEqual(table.rows[0]["Column"], "rowValue")
	}

	func test_twoColumnsOneRow() {
		let table = Table(columns: ["c1", "c2"])
			.addingRow(cells: ["v1", "v2"])
		
		XCTAssertEqual(table.rows[0]["c1"], "v1")
		XCTAssertEqual(table.rows[0]["c2"], "v2")
	}

	func test_oneColumnsOneRow() {
		let table = Table(columns: ["c"])
			.addingRow(cells: ["v1"])
			.addingRow(cells: ["v2"])
		
		XCTAssertEqual(table.rows[0]["c"], "v1")
		XCTAssertEqual(table.rows[1]["c"], "v2")
	}

	func test_twoColumnsTwoRows() {
		let table = Table(columns: ["c1", "c2"])
			.addingRow(cells: ["r1c1", "r1c2"])
			.addingRow(cells: ["r2c1", "r2c2"])
		
		XCTAssertEqual(table.rows[0]["c1"], "r1c1")
		XCTAssertEqual(table.rows[0]["c2"], "r1c2")
		XCTAssertEqual(table.rows[1]["c1"], "r2c1")
		XCTAssertEqual(table.rows[1]["c2"], "r2c2")
	}
}
