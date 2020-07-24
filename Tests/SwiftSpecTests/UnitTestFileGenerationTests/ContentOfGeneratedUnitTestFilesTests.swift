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
	func test_featureClass_oneWordName_ShouldReturnTestFileInterface() {
		given_featureWithName("Name")
		
		then_featureClassShouldBe("class NameTests : XCTestCase {")
	}
	
	func test_featureClass_twoWordsName_ShouldReturnTestFileInterface() {
		given_featureWithName("Feature name")
		
		then_featureClassShouldBe("class FeatureNameTests : XCTestCase {")
	}
	
	func test_featureClass_whenFeatureWithDashInName_ShouldReturnTestFileInterface() {
		given_featureWithName("Feature-name")
		
		then_featureClassShouldBe("class FeatureNameTests : XCTestCase {")
	}
	
	func test_featureClass_WhenFeatureWithIgnoreTag_ShouldReturnTestFileInterface() {
		given_featureWithName("Feature name", hasIgnoreTag:true)
		
		then_featureClassShouldBe("class IGNORE_FeatureNameTests : Ignore {")
	}
	
	func test_featureClass_WhenFeatureWithSwedishCharacters_ShouldReplacesWithAscii() {
		given_featureWithName("Xå Xä Xö Åx Äx Öx")
		
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
	func given_featureWithName(_ name: String, hasIgnoreTag: Bool = false) {
		given_feature(Feature(name: name, description: nil, tags: tags(hasIgnoreTag), location: Location(column: 1, line: 1)))
	}

	func given_featureWithTags(_ tagNames: [String]) {
		let tags = tagNames.map {Tag(name: $0, location: Location.zero())}
		given_feature(Feature(name: "name", description: nil, tags: tags, location: Location(column: 1, line: 1)))
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
		return Feature(name: "default name", description: nil, location: Location(column: 1, line: 1))
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
