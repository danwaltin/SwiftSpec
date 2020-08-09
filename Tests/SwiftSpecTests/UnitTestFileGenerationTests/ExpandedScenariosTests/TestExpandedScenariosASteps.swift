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
//  TestExpandedScenariosSteps.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-08-09.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
import GherkinSwift

class TestExpandedScenariosSteps : TestFileGenerationBase {
	// MARK: - Replacing keys with example values in steps
	func test_oneKeyOneGivenStepOneExamplesRow() {
		when_parsingScenarioOutline(
			"""
			Given the key '<key>'

			Examples:
				| key   |
				| value |
			""")

		then_stepsForExpandedScenario(0, shouldBe:
			"""
			Given the key 'value'
			""")
	}

	func test_oneKeyInTwoInstancesOneWhenStepOneExamplesRow() {
		when_parsingScenarioOutline(
			"""
			When foo <key> bar '<key>'

			Examples:
				| key   |
				| value |
			""")

		then_stepsForExpandedScenario(0, shouldBe:
			"""
			When foo value bar 'value'
			""")
	}

	func test_twoKeysInTwoInstancesOneThenStepOneExamplesRow() {
		when_parsingScenarioOutline(
			"""
			Then foo <key one> bar '<key one>'

			Examples:
				| key one     | key two      |
				| first value | second value |
			""")

		then_stepsForExpandedScenario(0, shouldBe:
			"""
			Then foo first value bar 'second value'
			""")
	}

	func test_oneKeyInTwoInstancesTwoStepsOneExamplesRow() {
		when_parsingScenarioOutline(
			"""
			Given foo <key>
			When <key> bar

			Examples:
				| key   |
				| value |
			""")

		then_stepsForExpandedScenario(0, shouldBe:
			"""
			Given foo value
			When value bar
			""")
	}

	func test_threeKeysInThreeStepsOneExamplesRow() {
		when_parsingScenarioOutline(
			"""
			Given foo <key one>
			When <key two> bar
			Then <key three>

			Examples:
				| key one | key two | key three |
				| v1      | v2      | v3        |
			""")

		then_stepsForExpandedScenario(0, shouldBe:
			"""
			Given foo v1
			When v2 bar
			Then v3
			""")
	}

	func test_threeKeysInThreeStepsThreeExamplesRowsInTwoGroups() {
		when_parsingScenarioOutline(
			"""
			Given alpha <k1>
			When beta <k2>
			Then gamma <k3>

			Examples: One
				| k1   | k2   | k3   |
				| v1_1 | v1_2 | v1_3 |
			Examples: Two
				| k1   | k2   | k3   |
				| v2_1 | v2_2 | v2_3 |
				| v2_1 | v2_2 | v2_3 |
			""")

		then_stepsForExpandedScenario(0, shouldBe:
			"""
			Given alpha v1_1
			When beta v1_2
			Then gamma v1_3
			""")

		then_stepsForExpandedScenario(1, shouldBe:
			"""
			Given alpha v2_1
			When beta v2_2
			Then gamma v2_3
			""")

		then_stepsForExpandedScenario(2, shouldBe:
			"""
			Given alpha v3_1
			When beta v3_2
			Then gamma v3_3
			""")
	}


	// MARK: - Replacing keys with example values in step table parameters
	func test_oneKeyOneGivenStepOneExamplesRow() {
		when_parsingScenarioOutline(
			"""
			Given the key '<key>'

			Examples:
				| key   |
				| value |
			""")

		then_stepsForExpandedScenario(0, shouldBe:
			"""
			Given the key 'value'
			""")
	}

	// MARK: - Givens, whens and thens
	private func when_parsingScenarioOutline(_ scenarioOutlineSteps: String) {
		when_parsing(featureWithSteps(scenarioOutlineSteps))
	}

	private func then_stepsForExpandedScenario(_ index: Int, shouldBe expected: String,
											   file: StaticString = #file, line: UInt = #line) {
		let expectedPickleResult = pickle(featureWithSteps(expected))
		
		guard let scenario = getFirstScenario(from: expectedPickleResult) else {
			XCTFail("Test data error, could not create a scenario from the given test data", file: file, line: line)
			return
		}
		
		let expectedSteps = scenario.steps
		
		assert.expandedScenario(atIndex: index, file, line) {
			XCTAssertEqual($0.steps, expectedSteps, file: file, line: line)
		}
	}
	
	private func getFirstScenario(from pickleResult: PickleResult) -> Scenario? {
		switch pickleResult {
		case .success(let doc):
			if let feature = doc.feature {
				return feature.scenarios.first
			} else {
				return nil
			}
		case .error( _):
			return nil
		}
	}
	
	private func featureWithSteps(_ steps: String) -> String {
		let feature =
			"""
			Feature: feature
			Scenario Outline: scenario outline
			"""

		return feature.appendLine(steps)
	}
}
