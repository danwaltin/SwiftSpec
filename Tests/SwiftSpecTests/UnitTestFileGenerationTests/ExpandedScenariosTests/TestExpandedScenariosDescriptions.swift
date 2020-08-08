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
//  TestExpandedScenariosDescriptions.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-08-08.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
import GherkinSwift

class TestExpandedScenariosDescriptions : TestFileGenerationBase {
	func test_descriptions() {
		when_parsing(
			"""
			Feature: f
			Scenario: One
			First description

			Scenario Outline: Two
			Second description

			Scenario Outline: Three

			Scenario Outline: Four
			Lorem Ipsum

				Examples:
					| header |
					| value  |
			""")

		then_description(forScenario: 0, shouldBe: "First description")
		then_description(forScenario: 1, shouldBe: "Second description")
		then_description(forScenario: 2, shouldBe: nil)
		then_description(forScenario: 3, shouldBe: "Lorem Ipsum")
	}
	
	// MARK: - Givens, whens and thens
	
	func then_description(forScenario index: Int, shouldBe expected: String?,
						  file: StaticString = #file, line: UInt = #line) {
		assert.expandedScenario(atIndex: index, file, line) {
			XCTAssertEqual($0.description, expected, file: file, line: line)
		}
	}
}
