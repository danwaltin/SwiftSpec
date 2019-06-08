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
//  ParseScenarioOutlinesTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-08-05.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec

class ParseScenarioOutlinesTests: TestParseBase {
	func test_oneScenarioOutlineWithOneExampleShouldReturnScenarioWithTitle() {
		when_parsingFeature([
			"Feature: feature title          ",
			"Scenario Outline: scenario title",
			"    Given <key>                 ",
			"                                ",
			"    Examples:                   ",
			"        | key |                 ",
			"        | one |                 "])
		
		then_shouldReturnScenariosWithTitles([
			"scenario title_0"]
		)
	}
	
	func test_oneScenarioOutlineWithTwoExamplesShouldReturnTwoScenarios() {
		when_parsingFeature([
			"Feature: feature title          ",
			"Scenario Outline: scenario title",
			"    Given <key>                 ",
			"                                ",
			"    Examples:                   ",
			"        | key |                 ",
			"        | one |                 ",
			"        | two |                 "])
		
		then_shouldReturnScenariosWithTitles([
			"scenario title_0",
			"scenario title_1"]
		)
	}

	func test_twoScenarioOutlinesWithTwoAndThreeExamplesShouldReturnFiveScenarios() {
		when_parsingFeature([
			"Feature: feature title        ",
			"Scenario Outline: scenario one",
			"    Given <key>               ",
			"                              ",
			"    Examples:                 ",
			"        | key |               ",
			"        | one |               ",
			"        | two |               ",
			"                              ",
			"Scenario Outline: scenario two",
			"    Given <key>               ",
			"                              ",
			"    Examples:                 ",
			"        | key   |             ",
			"        | one   |             ",
			"        | two   |             ",
			"        | three |             "])
		
		then_shouldReturnScenariosWithTitles([
			"scenario one_0",
			"scenario one_1",
			"scenario two_0",
			"scenario two_1",
			"scenario two_2"]
		)
	}

	// MARK: - Replacing keys with examples in steps
	
	func test_oneKeyOneExample() {
		when_parsingFeature([
			"Feature: feature title          ",
			"Scenario Outline: scenario title",
			"    Given the key <key>         ",
			"                                ",
			"    Examples:                   ",
			"        | key   |               ",
			"        | value |               "])
		
		then_shouldReturnScenarioWithSteps([
			Step.given("the key value")]
		)
	}

	func test_oneKeyInTwoInstancesInOneStepsOneExample() {
		when_parsingFeature([
			"Feature: feature title          ",
			"Scenario Outline: scenario title",
			"    Then foo <key> bar '<key>'  ",
			"                                ",
			"    Examples:                   ",
			"        | key   |               ",
			"        | value |               "])
		
		then_shouldReturnScenarioWithSteps([
			Step.then("foo value bar 'value'")]
		)
	}

	func test_twoKeyInInOneStepsOneExample() {
		when_parsingFeature([
			"Feature: feature title                ",
			"Scenario Outline: scenario title      ",
			"    Then foo <key one> bar '<key two>'",
			"                                      ",
			"    Examples:                         ",
			"        | key one | key two |         ",
			"        | one     | two     |         "])
		
		then_shouldReturnScenarioWithSteps([
			Step.then("foo one bar 'two'")]
		)
	}

	func test_oneKeyInTwoStepsOneExample() {
		when_parsingFeature([
			"Feature: feature title          ",
			"Scenario Outline: scenario title",
			"    Given foo <key>             ",
			"    When <key> bar              ",
			"                                ",
			"    Examples:                   ",
			"        | key   |               ",
			"        | value |               "])
		
		then_shouldReturnScenarioWithSteps([
			Step.given("foo value"),
			Step.when("value bar")]
		)
	}

	func test_threeKeysInThreeStepsOneExample() {
		when_parsingFeature([
			"Feature: feature title                    ",
			"Scenario Outline: scenario title          ",
			"    Given foo <key one>                   ",
			"    When <key two> bar                    ",
			"    Then <key three>                      ",
			"                                          ",
			"    Examples:                             ",
			"        | key one  | key two | key three |",
			"        | v1       | v2      | v3        |"])
		
		then_shouldReturnScenarioWithSteps([
			Step.given("foo v1"),
			Step.when("v2 bar"),
			Step.then("v3")]
		)
	}

	func test_threeKeysInThreeStepsTwoExamples() {
		when_parsingFeature([
			"Feature: feature title          ",
			"Scenario Outline: scenario title",
			"    Given alpha <k1>            ",
			"    When beta <k2>              ",
			"    Then gamma <k3>             ",
			"                                ",
			"    Examples:                   ",
			"        | k1   | k2   | k3   |  ",
			"        | v1_1 | v1_2 | v1_3 |  ",
			"        | v2_1 | v2_2 | v2_3 |  "])
		
		then_shouldReturnTwoScenariosWithSteps(
			[
				Step.given("alpha v1_1"),
				Step.when("beta v1_2"),
				Step.then("gamma v1_3")
			],
			[
				Step.given("alpha v2_1"),
				Step.when("beta v2_2"),
				Step.then("gamma v2_3")
			]
		)
	}
	
	// MARK: - Replacing keys with value in table parameters
	
	func test_oneColumnOneRow_oneKeyOneExample_replaceCell() {
		when_parsingFeature([
			"Feature: feature          ",
			"Scenario Outline: scenario",
			"    Given x               ",
			"        | Column |        ",
			"        | <key>  |        ",
			"                          ",
			"    Examples:             ",
			"        | key   |         ",
			"        | value |         "])
		
		then_shouldReturnScenarioWithSteps([
			Step.given("x", table(
				"Column",
				"value"))]
		)
	}

	func test_oneColumnOneRow_twoKeysOneExample_replaceCell() {
		when_parsingFeature([
			"Feature: feature          ",
			"Scenario Outline: scenario",
			"    Given x               ",
			"        | Column      |   ",
			"        | <one> <two> |   ",
			"                          ",
			"    Examples:             ",
			"        | one | two |     ",
			"        | v1  | v2  |     "])
		
		then_shouldReturnScenarioWithSteps([
			Step.given("x", table(
				"Column",
				"v1 v2"))]
		)
	}

	func test_oneColumnOneRow_oneKeyOneExample_replaceColumn() {
		when_parsingFeature([
			"Feature: feature          ",
			"Scenario Outline: scenario",
			"    When x                ",
			"        | <key>      |    ",
			"        | cell value |    ",
			"                          ",
			"    Examples:             ",
			"        | key         |   ",
			"        | Column Name |   "])
		
		then_shouldReturnScenarioWithSteps([
			Step.when("x", table(
				"Column Name",
				"cell value"))]
		)
	}

	func test_oneColumnOneRow_twoKeysOneExample_replaceColumn() {
		when_parsingFeature([
			"Feature: feature             ",
			"Scenario Outline: scenario   ",
			"    When x                   ",
			"        | <keyOne> <keyTwo> |",
			"        | cell value        |",
			"                             ",
			"    Examples:                ",
			"        | keyOne | keyTwo |  ",
			"        | c1     |c2      |  "])
		
		then_shouldReturnScenarioWithSteps([
			Step.when("x", table(
				"c1 c2",
				"cell value"))]
		)
	}

	func test_twoColumnsTwoRows_fourKeysTwoSameTwoExamples_replaceColumnAndCells() {
		when_parsingFeature([
			"Feature: feature                            ",
			"Scenario Outline: scenario                  ",
			"    Then x                                  ",
			"        | Constant Column | <key alfa>     |",
			"        | <same key>      | constant value |",
			"        | <key beta>      | <same key>     |",
			"                                            ",
			"    Examples:                               ",
			"        | key alfa | key beta | same key |  ",
			"        | XX       | YY       | ZZ       |  ",
			"        | AA       | BB       | CC       |  "])
		
		then_shouldReturnTwoScenariosWithSteps(
			[
				Step.then("x", table(
					"Constant Column", "XX",
					"ZZ", "constant value",
					"YY", "ZZ"))
			],
			[
				Step.then("x", table(
					"Constant Column", "AA",
					"CC", "constant value",
					"BB", "CC"))
			]
		)
	}
	
	// MARK: - Givens, whens, thens
	
	func then_shouldReturnScenarioWithSteps(_ steps: [Step], file: StaticString = #file, line: UInt = #line) {
		XCTAssertEqual(scenario(at: 0).steps, steps, file: file, line: line)
	}

	func then_shouldReturnTwoScenariosWithSteps(_ stepsScenarioOne: [Step], _ stepsScenarioTwo: [Step], file: StaticString = #file, line: UInt = #line) {
		XCTAssertEqual(scenario(at: 0).steps, stepsScenarioOne, file: file, line: line)
		XCTAssertEqual(scenario(at: 1).steps, stepsScenarioTwo, file: file, line: line)
	}
}

