//
//  ParseFeatureInformationTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-29.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

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
	
	// MARK:
	// MARK: Givens, whens, thens	
	private func then_featureTitleShouldBe(_ title: String) {
		XCTAssertEqual(actualFeature.title, title)
	}
}
