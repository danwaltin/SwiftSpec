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
	
	func test_trim() {
		XCTAssertEqual(     "".trim(),  "")
		XCTAssertEqual("line".trim(),   "line")
		XCTAssertEqual("line ".trim(),  "line")
		XCTAssertEqual(" line".trim(),  "line")
		XCTAssertEqual(" line".trim(),  "line")
		XCTAssertEqual(" line ".trim(), "line")
	}
	
	func test_appendLine() {
		XCTAssertEqual(""    .appendLine(""),     "")
		XCTAssertEqual(""    .appendLine("line"), "line")
		XCTAssertEqual("one" .appendLine("two"),  "one\ntwo")
		XCTAssertEqual("line".appendLine(),       "line\n")
	}
	
	func test_compactWhitespace() {
		XCTAssertEqual(""         .compactWhitespace(), "")
		XCTAssertEqual("  "       .compactWhitespace(), " ")
		XCTAssertEqual("   "      .compactWhitespace(), " ")
		XCTAssertEqual("one  "    .compactWhitespace(), "one ")
		XCTAssertEqual("one two"  .compactWhitespace(), "one two")
		XCTAssertEqual("one  two" .compactWhitespace(), "one two")
		XCTAssertEqual("one   two".compactWhitespace(), "one two")
		XCTAssertEqual("1  2   3" .compactWhitespace(), "1 2 3")
	}
	
	func test_camelCaseify() {
		XCTAssertEqual(""              .camelCaseify(), "")
		
		XCTAssertEqual("word"          .camelCaseify(), "Word")
		XCTAssertEqual("Word"          .camelCaseify(), "Word")
		XCTAssertEqual("WORD"          .camelCaseify(), "Word")

		XCTAssertEqual("one two"       .camelCaseify(), "OneTwo")
		XCTAssertEqual("one two  three".camelCaseify(), "OneTwoThree")
	}

	func test_deleteText() {
		XCTAssertEqual("Feature:title".deleteText("Feature:"), "title")
	}
	
	func test_allLines() {
		XCTAssertEqual(""        .allLines(), [])
		XCTAssertEqual(" "       .allLines(), [" "])
		XCTAssertEqual("line"    .allLines(), ["line"])
		XCTAssertEqual("one two" .allLines(), ["one two"])
		XCTAssertEqual("one\ntwo".allLines(), ["one", "two"])
		XCTAssertEqual("1\n2\n3" .allLines(), ["1", "2", "3"])
		XCTAssertEqual("\nline"  .allLines(), ["", "line"])
		XCTAssertEqual("line\n"  .allLines(), ["line", ""])
	}
}
