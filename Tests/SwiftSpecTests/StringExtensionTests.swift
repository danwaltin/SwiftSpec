//
//  StringExtensionTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import XCTest
@testable import SwiftSpec

class StringExtensionsTest: XCTestCase {
	
	// MARK:
	func test_trim() {
		XCTAssertEqual("",     "".trim())
		XCTAssertEqual("line", "line".trim())
		XCTAssertEqual("line", "line ".trim())
		XCTAssertEqual("line", " line".trim())
		XCTAssertEqual("line", " line".trim())
		XCTAssertEqual("line", " line ".trim())
	}
	
	// MARK:
	func test_appendLine() {
		XCTAssertEqual("",         "".appendLine(""))
		XCTAssertEqual("line",     "".appendLine("line"))
		XCTAssertEqual("one\ntwo", "one".appendLine("two"))
		XCTAssertEqual("line\n",   "line".appendLine())
	}
	
	// MARK:
	func test_compactWhitespace() {
		XCTAssertEqual("",        "".compactWhitespace())
		XCTAssertEqual(" ",       "  ".compactWhitespace())
		XCTAssertEqual(" ",       "   ".compactWhitespace())
		XCTAssertEqual("one ",    "one  ".compactWhitespace())
		XCTAssertEqual("one two", "one two".compactWhitespace())
		XCTAssertEqual("one two", "one  two".compactWhitespace())
		XCTAssertEqual("one two", "one   two".compactWhitespace())
		XCTAssertEqual("1 2 3",   "1  2   3".compactWhitespace())
	}
	
	// MARK:
	func test_camelCaseify() {
		XCTAssertEqual("",         "".camelCaseify())
		
		XCTAssertEqual("Word",     "word".camelCaseify())
		XCTAssertEqual("Word",     "Word".camelCaseify())
		XCTAssertEqual("Word",     "WORD".camelCaseify())

		XCTAssertEqual("OneTwo", "one two".camelCaseify())
		XCTAssertEqual("OneTwoThree", "one two  three".camelCaseify())
	}

	// MARK:
	func test_deleteText() {
		XCTAssertEqual("title", "Feature:title".deleteText("Feature:"))
	}
	
	// MARK:
	func test_allLines() {
		XCTAssertEqual([],              ""        .allLines())
		XCTAssertEqual([" "],           " "       .allLines())
		XCTAssertEqual(["line"],        "line"    .allLines())
		XCTAssertEqual(["one two"],     "one two" .allLines())
		XCTAssertEqual(["one", "two"],  "one\ntwo".allLines())
		XCTAssertEqual(["1", "2", "3"], "1\n2\n3" .allLines())
		XCTAssertEqual(["", "line"],    "\nline"  .allLines())
		XCTAssertEqual(["line", ""],    "line\n"  .allLines())
	}
}
