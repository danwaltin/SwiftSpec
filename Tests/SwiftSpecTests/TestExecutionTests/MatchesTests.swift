//
//  MatchesTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-23.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import XCTest
@testable import SwiftSpec

class MatchesTests : XCTestCase {
	// MARK:
	// MARK: Matches step
	func test_stepWithEmptyText_whenMatchingNonEmptyTest_shouldReturnFalse() {
		assertNoMatch(stepText: "", text: "text")
	}

	func test_stepWithNonEmptyText_whenMatchingEmptyTest_shouldReturnFalse() {
		assertNoMatch(stepText: "text", text: "")
	}

	func test_stepWithEmptyText_whenMatchingEmptyTest_shouldReturnTrue() {
		assertMatch(stepText: "", text: "")
	}

	func test_stepWithNonEmptyText_whenMatchingSameNonEmptyTest_shouldReturnTrue() {
		assertMatch(stepText: "non empty", text: "non empty")
	}

	func test_matchingIsCaseInSensitive() {
		assertMatch(stepText: "CASE in-sensitive", text: "case IN-SENSITIVE")
	}

	func test_matchingOneParametrizedValue() {
		assertMatch(stepText: "step with parameter '(.*)'", text: "step with parameter 'value'")
	}

	func test_matchingTwoParametrizedValues() {
		assertMatch(stepText: "step with parameters '(.*)' and (.*)", text: "step with parameters 'foo' and bar")
	}

	// MARK:
	// MARK: Getting matched parameters
	func test_oneMatchedParameter() {
		let actual = step("step with parameter '(.*)'")
			.matchParameters(text: "step with parameter 'value'")
		
		XCTAssertEqual(actual, ["value"])
	}

	func test_twoMatchedParameters() {
		let actual = step("step with parameters '(.*)' and (.*)")
			.matchParameters(text: "step with parameters 'foo' and bar")
		
		XCTAssertEqual(actual, ["foo", "bar"])
	}

	// MARK:
	// MARK: Factory methods
	private func step(_ text: String) -> StepBindingImplementation {
		return StepBindingImplementation(stepText: text, function: {_ in })
	}

	private func assertMatch(stepText: String, text: String) {
		XCTAssertTrue(isMatch(stepText: stepText, text: text))
	}

	private func assertNoMatch(stepText: String, text: String) {
		XCTAssertFalse(isMatch(stepText: stepText, text: text))
	}

	private func isMatch(stepText: String, text: String) -> Bool {
		return step(stepText).matches(text: text)
	}
}
