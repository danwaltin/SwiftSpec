//
//  TableColumnsTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-29.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import XCTest
@testable import SwiftSpec

class TableColumnsTests : XCTestCase {
	func test_zeroColumns() {
		let table = Table(columns: [])
		
		XCTAssertEqual(table.columns, [])
	}
	
	func test_oneColumn() {
		let table = Table(columns: ["column"])
		
		XCTAssertEqual(table.columns, ["column"])
	}
	
	func test_twoColumns() {
		let table = Table(columns: ["one", "two"])
		
		XCTAssertEqual(table.columns, ["one", "two"])
	}
}
