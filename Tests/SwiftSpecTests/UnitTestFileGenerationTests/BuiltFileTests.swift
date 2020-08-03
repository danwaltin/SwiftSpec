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
	private var actual = ""
	
	override func setUp() {
		super.setUp()
		
		mockBuilder = MockUnitTestBuilder()
	}
	
	func test_successfulResultWithFeatureAndZeroScenarios_shouldReturnBuiltTestFile() {
		given_builtParts(header: "header",
						 featureClass: "feature",
						 setupAndTearDown: "setupAndTearDown",
						 footer: "footer")
		
		when_generateUnitTestFrom(success(feature: feature(scenarios: [])))

		then_shouldGenerateUnitTestCode(
			"""
			header
			feature
			setupAndTearDown
			footer
			"""
		)
	}

	func test_successfulResultWithFeatureOneScenario_shouldReturnBuiltTestFile() {
		given_builtParts(header: "header",
						 featureClass: "feature",
						 setupAndTearDown: "setupAndTearDown",
						 scenarios: ["scenario"],
						 footer: "footer")
		
		when_generateUnitTestFrom(success(feature: feature(scenarios: [scenario()])))

		then_shouldGenerateUnitTestCode(
			"""
			header
			feature
			setupAndTearDown
			scenario
			footer
			"""
		)
	}

	func test_successfulResultWithFeatureTwoScenarios_shouldReturnBuiltTestFile() {
		given_builtParts(header: "header",
						 featureClass: "feature",
						 setupAndTearDown: "setupAndTearDown",
						 scenarios: ["scenario1", "scenario2"],
						 footer: "footer")
		
		when_generateUnitTestFrom(success(feature: feature(scenarios: [scenario(), scenario()])))

		then_shouldGenerateUnitTestCode(
			"""
			header
			feature
			setupAndTearDown
			scenario1
			scenario2
			footer
			"""
		)
	}

	func test_successfulResultWithoutFeature_shouldReturnOnlyBuiltHeader() {
		given_builtParts(header: "header")
		
		when_generateUnitTestFrom(success(feature: nil))

		then_shouldGenerateUnitTestCode(
			"""
			header
			"""
		)
	}
	
	func test_errorResult_butZeroParseErrors_shouldIncludeHeaderAndUnknownError() {
		given_builtParts(header: "header",
						 footer: "footer",
						 parseErrorFeatureClass: "parseErrorClass",
						 unknownError: "unknown error")

		when_generateUnitTestFrom(error(parseErrors: []))
		
		then_shouldGenerateUnitTestCode(
			"""
			header
			parseErrorClass
			unknown error
			footer
			"""
		)
	}

	func test_errorResult_oneParseError_shouldIncludeHeaderAndParseError() {
		given_builtParts(header: "header",
						 footer: "footer",
						 parseErrorFeatureClass: "parseErrorClass",
						 errors: ["parse error"])

		when_generateUnitTestFrom(error(parseErrors: [error()]))
		
		then_shouldGenerateUnitTestCode(
			"""
			header
			parseErrorClass
			parse error
			footer
			"""
		)
	}

	func test_errorResult_twoParseErrors_shouldIncludeHeaderAndParseErrors() {
		given_builtParts(header: "header",
						 footer: "footer",
						 parseErrorFeatureClass: "parseErrorClass",
						 errors: ["error one", "error two"])

		when_generateUnitTestFrom(error(parseErrors: [error(), error()]))
		
		then_shouldGenerateUnitTestCode(
			"""
			header
			parseErrorClass
			error one
			error two
			footer
			"""
		)
	}

	// MARK: - helpers, givens, whens and thens
	private func given_builtParts(header: String = "header should not be included",
								  featureClass: String = "feature should not be included",
								  setupAndTearDown: String = "setupAndTearDown should not be included",
								  scenarios: [String] = ["scenario should not be included"],
								  footer: String = "footer should not be included",
								  parseErrorFeatureClass: String = "parse error feature should not be included",
								  unknownError: String = "unknown error should not be included",
								  errors: [String] = ["error should not be included"]) {
		mockBuilder.builtHeader = header
		mockBuilder.builtFeatureClass = featureClass
		mockBuilder.builtSetupAndTearDown = setupAndTearDown
		mockBuilder.builtScenarios = scenarios
		mockBuilder.builtFooter = footer

		mockBuilder.builtParseErrorFeatureClass = parseErrorFeatureClass
		mockBuilder.builtUnknownError = unknownError
		mockBuilder.builtErrors = errors
	}
	
	private func when_generateUnitTestFrom(_ pickleResult: PickleResult) {
		actual = instanceToTest().generateUnitTest(result: pickleResult, fromFeatureFilePath: "")
	}
	
	private func then_shouldGenerateUnitTestCode(_ expected: String,
												 file: StaticString = #file, line: UInt = #line) {
		XCTAssertEqual(actual, expected, file: file, line: line)
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
