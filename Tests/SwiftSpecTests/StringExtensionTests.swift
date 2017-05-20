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
//  StringExtensionTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//
// ------------------------------------------------------------------------

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
