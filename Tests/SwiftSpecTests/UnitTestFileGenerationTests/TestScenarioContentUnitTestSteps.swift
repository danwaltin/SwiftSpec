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
//  TestScenarioContentUnitTestSteps.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-08-07.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
import GherkinSwift

class TestScenarioContentUnitTestSteps : TestFileGenerationBase {
	func test_scenarioWithOneGivenStep() {
		when_parsing(
			"""
			Feature: f
			Scenario: name
				Given something
			""")

		then_generatedScenarioShouldBe(
			"""
			func testName() {
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
			func testName() {
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
			func testName() {
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
			func testName() {
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
}
