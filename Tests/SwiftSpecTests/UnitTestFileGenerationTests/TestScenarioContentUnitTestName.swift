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
//  TestScenarioContentUnitTestName.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-08-07.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
import GherkinSwift

class TestScenarioContentUnitTestName : TestFileGenerationBase {
	
	func test_oneWordName() {
		when_parsing(
			"""
			Feature: f
			Scenario: Name
			""")
		
		then_generatedScenarioShouldBe(
			"""
			func testName() {
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
			func testOneTwo() {
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
			func testScenarioName() {
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
			func testXaXaXoAxAxOx() {
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
			func IGNORE_testName() {
			scenarioContext.tags = [\"\(ignoreTag)\"]
			}
			"""
		)
	}
}
