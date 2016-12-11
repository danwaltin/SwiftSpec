//
//  ParseSeveralFeaturesWithSameInstance.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-04.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//


import XCTest
@testable import SwiftSpec

class ParseSeveralFeaturesWithSameInstance : TestParseBase {

	func test_parsingTwoFeaturesWithTheSameParserInstance() {
		let instance = parser()
		
		let one = instance.parse(lines: [
			"@tagF1",
			"Feature: f1",
			"@tagS1",
			"Scenario: s1",
			"    Given g1"])
		
		let two = instance.parse(lines: [
			"@tagF2",
			"Feature: f2",
			"@tagS21",
			"Scenario: s2.1",
			"    Given g2.1.1",
			"    Given g2.1.2",
			"@tagS22",
			"Scenario: s2.2",
			"    Given g2.2.1"])
		
		XCTAssertEqual(one,
		               feature("f1", ["tagF1"], [
						scenario("s1", ["tagS1"], [
							given("g1")
							])
						]
			)
		)

		XCTAssertEqual(two,
		               feature("f2", ["tagF2"],[
						scenario("s2.1", ["tagS21"], [
							given("g2.1.1"),
							given("g2.1.2")]),
						scenario("s2.2", ["tagS22"], [
							given("g2.2.1")
							])
						]
			)
		)
	}
	
	private func feature(_ title: String, _ tags: [String], _ scenarios: [Scenario]) -> Feature {
		return Feature(title: title, tags: tags, scenarios:  scenarios)
	}
	
	private func scenario(_ title: String, _ tags: [String], _ steps: [Step]) -> Scenario {
		return Scenario(title: title, tags: tags, steps: steps)
	}
	
	private func given(_ text: String) -> Step {
		return Step.given(text)
	}
}
