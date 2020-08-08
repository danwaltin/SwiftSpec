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
//  TestExpandedScenariosOnlyScenarios.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-08-08.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
import GherkinSwift

class TestExpandedScenariosOnlyScenarios : TestFileGenerationBase {
	func test_featureWithOnlyScenarios_expandedScenariosShouldEqualScenarios() {
		when_parsing(
			"""
			Feature: f
			@someTag
			Scenario: Scenario One
				This is a description of the scenario
				Given something
				And something else

				When the following
					| Foo    |
					| bar    |
					| qwerty |

				Then good stuff happens
				But not bad stuff

			Scenario: Another scenario
				Given given
				When when
				Then then
			""")
		
		then_expandedScenariosShouldEqualScenarios()
	}

	// MARK: - Givens whens and thens
	private func then_expandedScenariosShouldEqualScenarios(file: StaticString = #file, line: UInt = #line) {
		assertFeature(file, line) {
			let expandedScenarios = $0.expandedScenarios()
			let scenarios = $0.scenarios
			
			XCTAssertEqual(scenarios, expandedScenarios, file: file, line: line)
		}
	}
}
