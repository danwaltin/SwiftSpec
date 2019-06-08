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
//  ParseFeatureInformationTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-29.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec

class ParseFeatureInformationTests: TestParseBase {

	func test_parseFeature_shouldReturnFeatureWithTitle() {
		when_parsingFeature([
			"Feature: feature title"])
		
		then_featureTitleShouldBe("feature title")
	}

	func test_parseFeature_whitespaceIsTrimmedFromTitle() {
		when_parsingFeature([
			"Feature: title with white space at end   "])
		
		then_featureTitleShouldBe("title with white space at end")
	}

	func test_parseFeature_withEmptyLine_shouldReturnFeatureWithTitle() {
		when_parsingFeature([
			"Feature: feature title",
			""])
		
		then_featureTitleShouldBe("feature title")
	}

	func test_parsingTwoFeaturesWithTheSameParserInstance() {
		let instance = parser()
		
		let one = instance.parse(lines: ["Feature: one"])
		XCTAssertEqual("one", one.title)

		let two = instance.parse(lines: ["Feature: two"])
		XCTAssertEqual("two", two.title)
	}
	
	// MARK: - Givens, whens, thens
	private func then_featureTitleShouldBe(_ title: String, file: StaticString = #file, line: UInt = #line) {
		XCTAssertEqual(actualFeature.title, title, file: file, line: line)
	}
}
