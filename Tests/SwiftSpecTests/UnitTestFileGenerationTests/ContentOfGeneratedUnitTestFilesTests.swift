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
//  ContentOfGeneratedUnitTestFilesTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//
// ------------------------------------------------------------------------
import XCTest
@testable import SwiftSpec
import  GherkinSwift

class ContentOfGeneratedUnitTestFilesTests: TestFileGenerationBase {

	private var feature: Feature!
	
	// MARK: - header
	func test_header() {
		given_feature(defaultFeature())
		
		let actual = instanceToTest().header()
		
		let expected = stringWithTrimmedLines([
			"//                                      ",
			"// AUTOGENERATED FILE                   ",
			"// This code was generated by SwiftSpec ",
			"//                                      ",
			"// Changes to this file may cause       ",
			"// incorrect behaviour and will be lost ",
			"// if the file is regenerated.          ",
			"//                                      ",
			"                                        ",
			"import XCTest                           ",
			"import SwiftSpec                        ",
			"                                        "])
		
		XCTAssertEqual(actual, expected)

	}

	// MARK: - Feature test class name
	func test_featureClass_oneWordTitle_ShouldReturnTestFileInterface() {
		given_featureWithTitle("Title")
		
		then_featureClassShouldBe("class TitleTests : XCTestCase {")
	}
	
	func test_featureClass_twoWordsTitle_ShouldReturnTestFileInterface() {
		given_featureWithTitle("Feature title")
		
		then_featureClassShouldBe("class FeatureTitleTests : XCTestCase {")
	}
	
	func test_featureClass_whenFeatureWithDashInTitle_ShouldReturnTestFileInterface() {
		given_featureWithTitle("Feature-title")
		
		then_featureClassShouldBe("class FeatureTitleTests : XCTestCase {")
	}
	
	func test_featureClass_WhenFeatureWithIgnoreTag_ShouldReturnTestFileInterface() {
		given_featureWithTitle("Feature title", hasIgnoreTag:true)
		
		then_featureClassShouldBe("class IGNORE_FeatureTitleTests : Ignore {")
	}
	
	func test_featureClass_WhenFeatureWithSwedishCharacters_ShouldReplacesWithAscii() {
		given_featureWithTitle("Xå Xä Xö Åx Äx Öx")
		
		then_featureClassShouldBe("class XaXaXoAxAxOxTests : XCTestCase {")
	}

	// MARK: - Setup and tear down

	func testSetupAndTearDown() {
		given_featureWithTags([])

		let expected = stringWithTrimmedLines([
			"var testRunner:TestRunner!                                   ",
			"var scenarioContext:ScenarioContext!                         ",
			"                                                             ",
			"override func setUp() {                                      ",
			"    super.setUp()                                            ",
			"    scenarioContext = ScenarioContextImplementation()        ",
			"    scenarioContext.featureTags = []                         ",
			"    testRunner = TestRunner(scenarioContext: scenarioContext)",
			"}                                                            ",
			"                                                             ",
			"override func tearDown() {                                   ",
			"    testRunner = nil                                         ",
			"    scenarioContext = nil                                    ",
			"    super.tearDown()                                         ",
			"}                                                            ",
			"                                                             "])

		let i = instanceToTest()
		let s = i.setupAndTearDown(feature: feature)
		XCTAssertEqual(s, expected)
	}
	
	func testSetupAndTearDownWhenFeatureHasTwoTags() {
		given_featureWithTags(["one", "two"])
		
		let expected = stringWithTrimmedLines([
			"var testRunner:TestRunner!                                   ",
			"var scenarioContext:ScenarioContext!                         ",
			"                                                             ",
			"override func setUp() {                                      ",
			"    super.setUp()                                            ",
			"    scenarioContext = ScenarioContextImplementation()        ",
			"    scenarioContext.featureTags = [\"one\", \"two\"]         ",
			"    testRunner = TestRunner(scenarioContext: scenarioContext)",
			"}                                                            ",
			"                                                             ",
			"override func tearDown() {                                   ",
			"    testRunner = nil                                         ",
			"    scenarioContext = nil                                    ",
			"    super.tearDown()                                         ",
			"}                                                            ",
			"                                                             "])

		let i = instanceToTest()
		let s = i.setupAndTearDown(feature: feature)
		XCTAssertEqual(s, expected)
		
	}
	
	// MARK: - Footer
	func testFooter_ShouldReturnEndTestClass() {
		XCTAssertEqual("}", instanceToTest().footer())
	}

	// MARK: - givens, whens thens
	func given_featureWithTitle(_ title: String, hasIgnoreTag: Bool = false) {
		given_feature(Feature(title: title, tags: tags(hasIgnoreTag)))
	}

	func given_featureWithTags(_ tags: [String]) {
		given_feature(Feature(title: "title", tags: tags))
	}

	private func given_feature(_ feature: Feature) {
		self.feature = feature
	}

	private func then_featureClassShouldBe(_ expected: String) {
		let actual = instanceToTest().featureClass(feature: feature)
		
		XCTAssertEqual(expected, actual)
	}

	// MARK: - Factory methods

	private func defaultFeature() -> Feature {
		return Feature(title: "default title")
	}

	private func instanceToTest() -> XCUnitTestGenerator {
		return XCUnitTestGenerator()
	}

	func stringWithTrimmedLines(_ lines: [String]) -> String {
		var s = ""
		for line in lines {
			s = s.appendLine(line.trim())
		}
		return s
	}
}
