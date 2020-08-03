// ------------------------------------------------------------------------
// Copyright 2020 Dan Waltin
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
//  ContentOfParseErrorUnitTestFilesTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-08-01.
//
// ------------------------------------------------------------------------
import XCTest
@testable import SwiftSpec
import  GherkinSwift

class ContentOfParseErrorUnitTestFilesTests: TestFileGenerationBase {

	// MARK: - Unknown error
	func test_unknownError() {
		let actual = instanceToTest().unknownError()
		let expected =
		"""
		func testUnknownErrorOccurred() {
		XCTFail("An unknown error occurred when parsing feature file")
		}
		"""
		
		XCTAssertEqual(actual, expected)
	}
	
	// MARK: - Parse error
	func test_parseError() {
		let parseError = ParseError(message: "parse error message",
									source: ParseErrorSource(location: Location(column: 13, line: 7),
															 uri: "path/to/file"))
		let actual = instanceToTest().error(index: 3, parseError: parseError)
		let expected =
		"""
		func testParseErrorOccurred3() {
		XCTFail("parse error message", file: "path/to/file", line: 7)
		}
		"""
		
		XCTAssertEqual(actual, expected)
	}

	// MARK: - Factory methods
	private func instanceToTest() -> UnitTestBuilderImp {
		return UnitTestBuilderImp()
	}
}
