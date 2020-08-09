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
//  TestExpandedScenariosUnitTestsNames.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-08-07.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
import GherkinSwift

class TestExpandedScenariosUnitTestsNames : TestFileGenerationBase {
	func test_oneScenario() {
		when_parsing(
			"""
			Feature: f
			Scenario: Name
			""")
		
		then_expandedScenarioNamesShouldBe([
			"Name"]
		)
	}

	func test_oneScenarioWithoutExamples() {
		when_parsing(
			"""
			Feature: f
			Scenario Outline: Name
			""")
		
		then_expandedScenarioNamesShouldBe([
			"Name"]
		)
	}

	func test_oneScenarioWithExamplesWithOneTableRow() {
		when_parsing(
			"""
			Feature: f
			Scenario Outline: Name
				Examples:
					| header |
					| value  |
			""")
		
		then_expandedScenarioNamesShouldBe([
			"Name_0"]
		)
	}

	func test_twoScenariosWithExamplesWithOneTableRow() {
		when_parsing(
			"""
			Feature: f
			Scenario Outline: One
				Examples:
					| header |
					| value1 |
			Scenario Outline: Two
				Examples:
					| header |
					| value2 |
			""")
		
		then_expandedScenarioNamesShouldBe([
			"One_0",
			"Two_0"]
		)
	}

	func test_oneScenarioWithExamplesWithTwoTableRows() {
		when_parsing(
			"""
			Feature: f
			Scenario Outline: Name
				Examples:
					| header |
					| v1     |
					| v2     |
			""")
		
		then_expandedScenarioNamesShouldBe([
			"Name_0",
			"Name_1"]
		)
	}

	func test_oneScenarioWithUnnamedExamplesAndNamedExamplesWithOneTableRowEach() {
		when_parsing(
			"""
			Feature: f
			Scenario Outline: Name
				Examples:
					| header |
					| v1     |

				Examples: named
					| header |
					| v2     |
			""")
		
		then_expandedScenarioNamesShouldBe([
			"Name_0",
			"Name_named_0"]
		)
	}

	func test_oneScenarioWithUnnamedExamplesAndNamedExamplesWithTwoAndThreeTableRows() {
		when_parsing(
			"""
			Feature: f
			Scenario Outline: scenario name
				Examples:
					| header |
					| v1     |
					| v2     |

				Examples: named
					| header |
					| v3     |
					| v4     |
					| v5     |
			""")
		
		then_expandedScenarioNamesShouldBe([
			"scenario name_0",
			"scenario name_1",
			"scenario name_named_0",
			"scenario name_named_1",
			"scenario name_named_2"]
		)
	}

	func test_oneScenarioWithOneNamedExamplesWithSpaceInNameWithOneTableRow() {
		when_parsing(
			"""
			Feature: f
			Scenario Outline: Name

				Examples: foo bar
					| header |
					| v2     |
			""")
		
		then_expandedScenarioNamesShouldBe([
			"Name_foo bar_0"]
		)
	}

	func test_oneScenarioWithOneNamedExamplesWithDashInNameWithOneTableRow() {
		when_parsing(
			"""
			Feature: f
			Scenario Outline: Name

				Examples: foo-bar
					| header |
					| v2     |
			""")
		
		then_expandedScenarioNamesShouldBe([
			"Name_foo-bar_0"]
		)
	}

	func test_oneScenarioWithTwoNamedExamplesWithTwoAndThreeTableRows() {
		when_parsing(
			"""
			Feature: f
			Scenario Outline: scenario name
				Examples: One
					| header |
					| v1     |
					| v2     |

				Examples: Two
					| header |
					| v3     |
					| v4     |
					| v5     |
			""")
		
		then_expandedScenarioNamesShouldBe([
			"scenario name_One_0",
			"scenario name_One_1",
			"scenario name_Two_0",
			"scenario name_Two_1",
			"scenario name_Two_2"]
		)
	}

	func test_oneScenarioWithExamplesWithoutTable() {
		when_parsing(
			"""
			Feature: f
			Scenario Outline: scenario name
				Examples:
			""")
		
		then_expandedScenarioNamesShouldBe([
			"scenario name"]
		)
	}

	func test_oneScenarioWithExamplesWithTableWithoutRows() {
		when_parsing(
			"""
			Feature: f
			Scenario Outline: scenario name
				Examples:
					| header |
			""")
		
		then_expandedScenarioNamesShouldBe([
			"scenario name"]
		)
	}

	func test_twoScenariosWithExamples() {
		when_parsing(
			"""
			Feature: f

			Scenario Outline: scenario one
				Examples:
					| header |
				Examples: named
					| header |
					| value1 |
					| value2 |

			Scenario Outline: scenario two
				Examples: qwerty
					| lorem  |
					| ipsum1 |
					| ipsum2 |
					| ipsum3 |
			""")
		
		then_expandedScenarioNamesShouldBe([
			"scenario one_named_0",
			"scenario one_named_1",
			"scenario two_qwerty_0",
			"scenario two_qwerty_1",
			"scenario two_qwerty_2"]
		)
	}

	// MARK: - Givens whens and thens
	private func then_expandedScenarioNamesShouldBe(_ expected: [String], file: StaticString = #file, line: UInt = #line) {
		assert.feature(file, line) {
			let scenarios = $0.expandedScenarios()
			
			let actual = scenarios.map { $0.name}
			
			XCTAssertEqual(actual, expected, file: file, line: line)

		}
	}
}
