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
//  TestFileGenerationBase.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-26.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
import  GherkinSwift

class TestFileGenerationBase : XCTestCase {
	var pickledDocument: GherkinDocument!
	
	func when_parsing(_ feature: String) {
		let featureParser = GherkinFeatureParser(configuration: ParseConfiguration(),
												 languages: LanguagesConfiguration(defaultLanguageKey: "en"))
		let lines = feature.allLines()
		let result = featureParser.pickle(lines: lines, fileUri: "feature/file/path")
	
		if case .success(let document) = result {
			pickledDocument = document
		}
	}

	func then_generatedScenarioShouldBe(_ lines: String, file: StaticString = #file, line: UInt = #line) {
		guard let scenario = pickledDocument.feature?.scenarios.first else {
			XCTFail("No scenario found", file: file, line: line)
			return
		}
		let expected = trimmedLines(lines)
		let actual = instanceToTest().scenario(scenario: scenario)

		XCTAssertEqual(actual, expected, file: file, line: line)
	}

	// MARK: - Factory methods
	
	private func instanceToTest() -> UnitTestBuilderImp {
		return UnitTestBuilderImp()
	}

	func trimmedLines(_ s: String) -> String {
		var trimmed = ""
		for line in s.allLines() {
			trimmed = trimmed.appendLine(line.trim())
		}
		return trimmed
	}
}
