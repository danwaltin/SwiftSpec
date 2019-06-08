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
//  ParseScenariosTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-03.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec

class ParseScenariosTests: TestParseBase {
	func test_oneScenarioShouldReturnScenarioWithTitle() {
		when_parsingFeature([
			"Feature: feature title  ",
			"Scenario: scenario title"])
		
		then_shouldReturnScenariosWithTitles([
			"scenario title"]
		)
	}

	func test_twoScenariosShouldReturnScenariosWithTitles() {
		when_parsingFeature([
			"Feature: feature title",
			"Scenario: scenario one",
			"Scenario: scenario two"])
		
		then_shouldReturnScenariosWithTitles([
			"scenario one",
			"scenario two"]
		)
	}
	
	func test_scenarioWithOneGivenStep() {
		when_parsingFeature([
			"Feature: feature  ",
			"Scenario: scenario",
			"    Given there is something"])

		then_shouldReturnScenarioWithSteps([
			Step.given("there is something")]
		)
	}

	func test_scenarioWithOneWhenStep() {
		when_parsingFeature([
			"Feature: feature  ",
			"Scenario: scenario",
			"    When something happens"])
		
		then_shouldReturnScenarioWithSteps([
			Step.when("something happens")]
		)
	}

	func test_scenarioWithOneThenStep() {
		when_parsingFeature([
			"Feature: feature  ",
			"Scenario: scenario",
			"    Then something is the result"])
		
		then_shouldReturnScenarioWithSteps([
			Step.then("something is the result")]
		)
	}

	// MARK:
	// MARK: Table parameters to steps
	
	func test_tableParametersToSteps_oneColumnOneRow() {
		when_parsingFeature([
			"Feature: feature  ",
			"Scenario: scenario",
			"    Given x ",
			"        | Column |    ",
			"        | value  |    "])
		
		then_shouldReturnScenarioWithSteps([
			Step.given("x", table(
				"Column",
				"value"))]
		)
	}

	func test_tableParametersToSteps_oneColumnTwoRows() {
		when_parsingFeature([
			"Feature: feature  ",
			"Scenario: scenario",
			"    When y            ",
			"        | col |       ",
			"        | v1  |       ",
			"        | v2  |       "])
		
		then_shouldReturnScenarioWithSteps([
			Step.when("y", table(
				"col",
				"v1",
				"v2"))]
		)
	}

	func test_tableParametersToSteps_twoColumnsOneRow() {
		when_parsingFeature([
			"Feature: feature  ",
			"Scenario: scenario",
			"    Then z            ",
			"        | c1   | c2   |",
			"        | r1c1 | r1c2 |"])
		
		then_shouldReturnScenarioWithSteps([
			Step.then("z", table(
				"c1", "c2",
				"r1c1", "r1c2"))]
		)
	}

	func test_tableParametersToSteps_twoColumnsTwoRows() {
		when_parsingFeature([
			"Feature: feature  ",
			"Scenario: scenario",
			"    When alfa    ",
			"        | A | B |",
			"        | c | d |",
			"        | e | f |",
			"                 ",
			"    Then beta    ",
			"        | G | H |",
			"        | i | j |",
			"        | k | l |"])
		
		then_shouldReturnScenarioWithSteps([
			Step.when("alfa", table(
				"A", "B",
				"c", "d",
				"e", "f")),
			Step.then("beta", table(
				"G", "H",
				"i", "j",
				"k", "l"))]
		)
	}

	// MARK: - Givens, whens, thens
	
	func then_shouldReturnScenarioWithSteps(_ steps: [Step], file: StaticString = #file, line: UInt = #line) {
		XCTAssertEqual(scenario(at: 0).steps, steps, file: file, line: line)
	}
}

