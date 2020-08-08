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

	func test_oneScenarioWithUnnamedExamplesAndNamedExamlesWithOneTableRowEach() {
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
			"Name_Named_0"]
		)
	}

	func test_oneScenarioWithUnnamedExamplesAndNamedExamlesWithTwoAndThreeTableRows() {
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
			"ScenarioName_0",
			"ScenarioName_1",
			"ScenarioName_named_0",
			"ScenarioName_named_1",
			"ScenarioName_named_2"]
		)
	}

	func test_oneScenarioWithOneNamedExamlesWithSpaceInNameWithOneTableRow() {
		when_parsing(
			"""
			Feature: f
			Scenario Outline: Name

				Examples: foo bar
					| header |
					| v2     |
			""")
		
		then_expandedScenarioNamesShouldBe([
			"Name_FooBar_0"]
		)
	}

	func test_oneScenarioWithOneNamedExamlesWithDashInNameWithOneTableRow() {
		when_parsing(
			"""
			Feature: f
			Scenario Outline: Name

				Examples: foo-bar
					| header |
					| v2     |
			""")
		
		then_expandedScenarioNamesShouldBe([
			"Name_FooBar_0"]
		)
	}

	func test_oneScenarioWithOneNamedExamlesWithSwedishCharactersInNameWithOneTableRow() {
		when_parsing(
			"""
			Feature: f
			Scenario Outline: Name

				Examples: Xå Xä Xö Åx Äx Öx
					| header |
					| v2     |
			""")
		
		then_expandedScenarioNamesShouldBe([
			"Name_XaXaXoAxAxOx_0"]
		)
	}
	
	func test_oneScenarioWithTwoNamedExamlesWithTwoAndThreeTableRows() {
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
			"ScenarioName_One_0",
			"ScenarioName_One_1",
			"ScenarioName_Two_0",
			"ScenarioName_Two_1",
			"ScenarioName_Two_2"]
		)
	}

	// MARK: - Givens whens and thens
	private func then_expandedScenarioNamesShouldBe(_ expected: [String], file: StaticString = #file, line: UInt = #line) {
		assertFeature(file, line) {
			let scenarios = $0.expandedScenarios()
			
			let actual = scenarios.map { $0.name}
			
			XCTAssertEqual(actual, expected, file: file, line: line)

		}
	}
}
