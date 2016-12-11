//
//  TableEqualityTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-29.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import XCTest
@testable import SwiftSpec

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
