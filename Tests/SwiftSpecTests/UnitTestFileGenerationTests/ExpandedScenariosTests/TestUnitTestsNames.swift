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
//  TestUnitTestsNames.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-08-07.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
import GherkinSwift

class TestUnitTestsNames : TestFileGenerationBase {
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
	
	// MARK: - Givens whens and thens
	private func then_expandedScenarioNamesShouldBe(_ expected: [String], file: StaticString = #file, line: UInt = #line) {
		guard let feature = feature() else {
			XCTFail("No scenario found", file: file, line: line)
			return
		}

		let scenarios = feature.expandedScenarios()
		
		let actual = scenarios.map { $0.name}
		
		XCTAssertEqual(actual, expected, file: file, line: line)
	}
	
	// MARK: - Helpers
	private func feature() -> Feature? {
		return pickledDocument?.feature
	}
}
