// ------------------------------------------------------------------------
// Copyright 2020 Dan Waltin
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
//  BuiltFileTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-08-01.
//
// ------------------------------------------------------------------------
import XCTest
@testable import SwiftSpec
import  GherkinSwift

class BuiltFileTests: TestFileGenerationBase {

	private var mockBuilder: MockUnitTestBuilder!
	
	override func setUp() {
		super.setUp()
		
		mockBuilder = MockUnitTestBuilder()
	}
	
	func test_shouldReturnBuiltTestFile() {
	
		mockBuilder.builtHeader = "header"
		mockBuilder.builtFeatureClass = "feature"
		mockBuilder.builtSetupAndTearDown = "setupAndTearDown"
		mockBuilder.builtScenarios = ["scenario1", "scenario2"]
		mockBuilder.builtFooter = "footer"
		
		let s1 = Scenario(name: "s1", description: nil, tags: [], location: Location.zero(), steps: [], examples: [], isScenarioOutline: false, localizedKeyword: "Scenario")
		let s2 = Scenario(name: "s2", description: nil, tags: [], location: Location.zero(), steps: [], examples: [], isScenarioOutline: false, localizedKeyword: "Scenario")
		let feature = Feature(name: "feature",
							  description: nil,
							  background: nil,
							  location: Location.zero(),
							  scenarios: [s1, s2],
							  language: "en",
							  localizedKeyword: "Feature")
		
		let pickleResult: PickleResult = .success(GherkinDocument(comments: [], feature: feature, uri: "path/to/feature"))

		let actual = instanceToTest().generateUnitTest(result: pickleResult)
		let expected =
			"""
			header
			feature
			setupAndTearDown
			scenario1
			scenario2
			footer
			"""
		
		XCTAssertEqual(actual, expected)
	}
	
	private func instanceToTest() -> XCUnitTestGenerator {
		return XCUnitTestGenerator(builder: mockBuilder)
	}
}
