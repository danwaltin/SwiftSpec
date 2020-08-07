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
//  ScenarioContentUnitTestTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-04.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
@testable import GherkinSwift

class ScenarioContentUnitTestTests : TestFileGenerationBase {
	
	// MARK: - Scenario test method name
	func test_oneWordName() {
		when_parsing(
			"""
			Feature: f
			Scenario: Name
			""")
		
		then_generatedScenarioShouldBe(
			"""
			func testNameTests() {
			}
			"""
		)
	}

	func test_twoWordsName() {
		when_parsing(
			"""
			Feature: f
			Scenario: one two
			""")

		then_generatedScenarioShouldBe(
			"""
			func testOneTwoTests() {
			}
			"""
		)
	}
	
	func test_scenarioWithDashInName() {
		when_parsing(
			"""
			Feature: f
			Scenario: Scenario-name
			""")
		
		then_generatedScenarioShouldBe(
			"""
			func testScenarioNameTests() {
			}
			"""
		)
	}
	
	func test_scenarioWithSwedishCharacters_ShouldReplaceWithAscii() {
		when_parsing(
			"""
			Feature: f
			Scenario: Xå Xä Xö Åx Äx Öx
			""")
		
		then_generatedScenarioShouldBe(
			"""
			func testXaXaXoAxAxOxTests() {
			}
			"""
		)
	}
	
	func test_ignoredScenario() {
		when_parsing(
			"""
			Feature: f
			@ignore
			Scenario: Name
			""")
		
		then_generatedScenarioShouldBe(
			"""
			func IGNORE_testNameTests() {
			scenarioContext.tags = [\"\(ignoreTag)\"]
			}
			"""
		)
	}
	
	// MARK: - Tags

	func test_scenarioWithOneTag() {
		when_parsing(
			"""
			Feature: f
			@tag
			Scenario: Name
			""")
		
		then_generatedScenarioShouldBe(
			"""
			func testNameTests() {
			scenarioContext.tags = [\"tag\"]
			}
			"""
		)
	}

	func test_scenarioWithTwoTags() {
		when_parsing(
			"""
			Feature: f
			@one @two
			Scenario: Name
			""")
		
		then_generatedScenarioShouldBe(
			"""
			func testNameTests() {
			scenarioContext.tags = [\"one\", \"two\"]
			}
			"""
		)
	}

	// MARK: - Steps
	func test_scenarioWithOneGivenStep() {
		when_parsing(
			"""
			Feature: f
			Scenario: name
				Given something
			""")

		then_generatedScenarioShouldBe(
			"""
			func testNameTests() {
			do {
			try testRunner.executeStep(.given, \"something\")
			} catch {
			XCTFail(\"\\(error)\")
			}
			}
			"""
		)
	}

	func test_scenarioWithOneWhenStep() {
		when_parsing(
			"""
			Feature: f
			Scenario: name
				When something
			""")
		
		then_generatedScenarioShouldBe(
			"""
			func testNameTests() {
			do {
			try testRunner.executeStep(.when, \"something\")
			} catch {
			XCTFail(\"\\(error)\")
			}
			}
			"""
		)
	}

	func test_scenarioWithOneThenStep() {
		when_parsing(
			"""
			Feature: f
			Scenario: name
				Then something
			""")
		
		then_generatedScenarioShouldBe(
			"""
			func testNameTests() {
			do {
			try testRunner.executeStep(.then, \"something\")
			} catch {
			XCTFail(\"\\(error)\")
			}
			}
			"""
		)
	}

	func test_scenarioWithMultipleSteps() {
		when_parsing(
			"""
			Feature: f
			Scenario: name
				Given a
				And b
				When c
				Then d
				But e
			""")
		
		then_generatedScenarioShouldBe(
			"""
			func testNameTests() {
			do {
			try testRunner.executeStep(.given, \"a\")
			try testRunner.executeStep(.and, \"b\")
			try testRunner.executeStep(.when, \"c\")
			try testRunner.executeStep(.then, \"d\")
			try testRunner.executeStep(.but, \"e\")
			} catch {
			XCTFail(\"\\(error)\")
			}
			}
			"""
		)
	}

	// MARK: - Steps with table arguments
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
			func testNameTests() {
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
			func testNameTests() {
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
			func testNameTests() {
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
			func testNameTests() {
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

	// MARK: - givens, whens thens
	
	private func then_generatedScenarioShouldBe(_ lines: String, file: StaticString = #file, line: UInt = #line) {
		let expected = trimmedLines(lines)
		let actual = instanceToTest().scenario(scenario: (pickledDocument.feature?.scenarios.first!)!)

		XCTAssertEqual(actual, expected, file: file, line: line)
	}
	
	// MARK: - Factory methods
	
	private func instanceToTest() -> UnitTestBuilderImp {
		return UnitTestBuilderImp()
	}	
}
