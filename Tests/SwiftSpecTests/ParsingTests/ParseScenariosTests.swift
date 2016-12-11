//
//  ParseScenariosTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-03.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

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

	// MARK:
	// MARK: Givens, whens, thens
	
	func then_shouldReturnScenarioWithSteps(_ steps: [Step]) {
		XCTAssertEqual(scenario(at: 0).steps, steps)
	}
}

