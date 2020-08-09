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
	func test_oneGivenStepOneExamplesRow() {
		when_parsingScenarioOutline(
			"""
			Given given '<something>'

			Examples:
				| something |
				| value     |
			""")

		then_stepsForExpandedScenario(0, shouldBe:
			"""
			Given given 'value'
			""")
	}

	func test_oneWhenStepTwoExamplesRows() {
		when_parsingScenarioOutline(
			"""
			When when '<something>'

			Examples:
				| something |
				| value one |
				| value two |
			""")

		then_stepsForExpandedScenario(0, shouldBe:
			"""
			When when 'value one'
			""")

		then_stepsForExpandedScenario(1, shouldBe:
			"""
			When when 'value two'
			""")
	}

	func test_severalStepsExamplesRowsAndColumns() {
		when_parsingScenarioOutline(
			"""
			Given account balance 100
			When buying food for <amount>
			Then the account balance is <new balance>

			Examples:
				| amount | new balance |
				| 12     | 78          |
				| 34     | 66          |
			""")

		then_stepsForExpandedScenario(0, shouldBe:
			"""
			Given account balance 100
			When buying food for 12
			Then the account balance is 78
			""")

		then_stepsForExpandedScenario(1, shouldBe:
			"""
			Given account balance 100
			When buying food for 34
			Then the account balance is 66
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
