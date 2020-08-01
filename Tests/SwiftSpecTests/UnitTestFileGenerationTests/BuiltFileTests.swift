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
	
	func test_successfulResultWithFeature_shouldReturnBuiltTestFile() {
		
		mockBuilder.builtHeader = "header"
		mockBuilder.builtFeatureClass = "feature"
		mockBuilder.builtSetupAndTearDown = "setupAndTearDown"
		mockBuilder.builtScenarios = ["scenario1", "scenario2"]
		mockBuilder.builtFooter = "footer"
		
		let pickleResult = success(feature: feature(scenarios: [scenario(), scenario()]))
		
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

	func test_successfulResultWithoutFeature_shouldReturnOnlyBuiltHeader() {
		
		mockBuilder.builtHeader = "header"
		mockBuilder.builtFeatureClass = "feature should not be included"
		mockBuilder.builtSetupAndTearDown = "setupAndTearDown should not be included"
		mockBuilder.builtScenarios = ["scenario should not be included"]
		mockBuilder.builtFooter = "footer should not be included"
		
		let pickleResult = success(feature: nil)
		
		let actual = instanceToTest().generateUnitTest(result: pickleResult)
		let expected =
		"""
		header
		"""
		
		XCTAssertEqual(actual, expected)
	}
	
	func test_errorResult_butZeroParseErrors_shouldIncludeHeaderAndUnknownError() {
		mockBuilder.builtHeader = "header"
		mockBuilder.builtFeatureClass = "feature should not be included"
		mockBuilder.builtSetupAndTearDown = "setupAndTearDown should not be included"
		mockBuilder.builtScenarios = ["scenario should not be included"]
		mockBuilder.builtFooter = "footer should not be included"

		mockBuilder.builtUnknownError = "unknown error"
		mockBuilder.builtErrors = ["error should not be included"]
		
		let pickleResult = error(parseErrors: [])
		
		let actual = instanceToTest().generateUnitTest(result: pickleResult)
		let expected =
		"""
		header
		unknown error
		"""
		
		XCTAssertEqual(actual, expected)
	}
	

	private func instanceToTest() -> XCUnitTestGenerator {
		return XCUnitTestGenerator(builder: mockBuilder)
	}
	
	private func success(feature: Feature?) -> PickleResult {
		return .success(GherkinDocument(comments: [], feature: feature, uri: "path/to/feature"))
	}

	private func error(parseErrors: [ParseError]) -> PickleResult {
		return .error(parseErrors)
	}

	private func feature(scenarios: [Scenario]) -> Feature {
		return Feature(name: "feature",
					   description: nil,
					   background: nil,
					   location: Location.zero(),
					   scenarios: scenarios,
					   language: "en",
					   localizedKeyword: "Feature")
		
	}
	
	private func scenario() -> Scenario {
		return Scenario(name: "scenario",
						description: nil,
						tags: [],
						location: Location.zero(),
						steps: [],
						examples: [],
						isScenarioOutline: false,
						localizedKeyword: "Scenario")
	}
	
	private func error() -> ParseError {
		return ParseError(message: "message", source: ParseErrorSource(location: Location(column: 1, line: 1), uri: ""))
	}
}
