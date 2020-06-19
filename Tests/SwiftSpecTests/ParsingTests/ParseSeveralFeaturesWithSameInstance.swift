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
//  ParseSeveralFeaturesWithSameInstance.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-04.
//
// ------------------------------------------------------------------------
import XCTest
@testable import SwiftSpec
import GherkinSwift

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
