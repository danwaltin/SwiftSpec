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
//  TestScenarioContentUnitTestStepsWithTableParameters.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-08-07.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
import GherkinSwift

class TestScenarioContentUnitTestStepsWithTableParameters : TestFileGenerationBase {
	func test_scenarioWithGivenStep_withTableArgumentWithOneRow() {
		when_parsing(
			"""
			Feature: f
			Scenario: name
				Given a
					| col  |
					| r1c1 |
			""")

		then_generatedScenarioShouldBe(
			"""
			func testName() {
			do {
			let table1 = TableParameter(columns: [\"col\"])
			.addingRow(cells: [\"r1c1\"])
			try testRunner.executeStep(.given, \"a\", table1)
			} catch {
			XCTFail(\"\\(error)\")
			}
			}
			"""
		)
	}

	func test_scenarioWithWhenStep_withTableArgumentWithTwoRows() {
		when_parsing(
			"""
			Feature: f
			Scenario: name
				When a
					| col  |
					| r1c1 |
					| r2c1 |
			""")
		
		then_generatedScenarioShouldBe(
			"""
			func testName() {
			do {
			let table1 = TableParameter(columns: [\"col\"])
			.addingRow(cells: [\"r1c1\"])
			.addingRow(cells: [\"r2c1\"])
			try testRunner.executeStep(.when, \"a\", table1)
			} catch {
			XCTFail(\"\\(error)\")
			}
			}
			"""
		)
	}

	func test_scenarioWithThenStep_withTableArgumentWithTwoColumns() {
		when_parsing(
			"""
			Feature: f
			Scenario: name
				Then a
					| c1   | c2   |
					| r1c1 | r1c2 |
			""")

		then_generatedScenarioShouldBe(
			"""
			func testName() {
			do {
			let table1 = TableParameter(columns: [\"c1\", \"c2\"])
			.addingRow(cells: [\"r1c1\", \"r1c2\"])
			try testRunner.executeStep(.then, \"a\", table1)
			} catch {
			XCTFail(\"\\(error)\")
			}
			}
			"""
		)
	}

	func test_scenarioWithThreeSteps_firstAndLastWithTableParameters() {
		when_parsing(
			"""
			Feature: f
			Scenario: name
				Given g
					| c1 |
					| v1 |
				When w
				Then t
					| c2 |
					| v2 |
			""")
		
		then_generatedScenarioShouldBe(
			"""
			func testName() {
			do {
			let table1 = TableParameter(columns: [\"c1\"])
			.addingRow(cells: [\"v1\"])
			try testRunner.executeStep(.given, \"g\", table1)
			try testRunner.executeStep(.when, \"w\")
			let table2 = TableParameter(columns: [\"c2\"])
			.addingRow(cells: [\"v2\"])
			try testRunner.executeStep(.then, \"t\", table2)
			} catch {
			XCTFail(\"\\(error)\")
			}
			}
			"""
		)
	}
}
