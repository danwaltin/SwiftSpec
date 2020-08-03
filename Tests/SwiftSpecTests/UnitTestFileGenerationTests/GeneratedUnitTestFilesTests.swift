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
//  TestUnitTestFiles.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//
// ------------------------------------------------------------------------
import XCTest
@testable import SwiftSpec
import  GherkinSwift

class GeneratedUnitTestFilesTests : TestFileGenerationBase {
	
	var mockFileSystem: MockFileSystem!
	var mockFeatureParser: MockFeatureParser!
	var mockUnitTestGenerator: MockUnitTestGenerator!
	
	override func setUp() {
		super.setUp()
		
		mockFileSystem = MockFileSystem()
		mockFeatureParser = MockFeatureParser()
		mockUnitTestGenerator = MockUnitTestGenerator()
		
		given_parsedFeature(feature(name: "default feature"))
	}
	
	override func tearDown() {
		mockFileSystem = nil
		mockFeatureParser = nil
		mockUnitTestGenerator = nil
		
		super.tearDown()
	}
	
	// MARK: - created files
	
	func test_zeroFiles() {
		given_zeroFiles()
		
		when_generateUnitTests()
		
		then_theZeroUnitTestFilesShouldBeCreated()
	}
	
	func test_oneFileNotAFeature() {
		given_files(
			["NotAFeature.txt"]
		)
		
		when_generateUnitTests(baseDirectory: "/base/directory")
		
		then_theZeroUnitTestFilesShouldBeCreated()
	}
	
	func test_oneFeatureFile() {
		given_files(
			["Specification.feature"]
		)
		
		when_generateUnitTests(baseDirectory: "/base/directory")
		
		then_theFollowingUnitTestFilesShouldBeCreated(
			["/base/directory/Specification.feature.swift"]
		)
	}
	
	func test_twoFeatureFiles() {
		given_files(
			["One.feature",
			 "Two.feature"]
		)
		
		when_generateUnitTests(baseDirectory: "/base/directory")
		
		then_theFollowingUnitTestFilesShouldBeCreated(
			["/base/directory/One.feature.swift",
			 "/base/directory/Two.feature.swift"]
		)
	}
	
	// MARK: - integrations
	
	func test_shouldParsePath() {
		given_files(
			["Specification.feature"]
		)
		
		when_generateUnitTests(baseDirectory: "base/directory")
		
		then_pathFromWhichFeatureIsParsedShouldBe("base/directory/Specification.feature")
	}
	
	func test_shouldParseLinesFromFile() {
		given_files(
			["Specification.feature"]
		)
		given_fileContent(
			["line one",
			 "line two"]
		)
		
		when_generateUnitTests()
		
		then_linesFromWhichFeatureIsParsedShouldBe(
			["line one",
			 "line two"]
		)
	}
	
	func test_shouldGenerateContentFromFeatureParser() {
		given_files(
			["Specification.feature"]
		)
		given_parsedFeature(feature(name: "parsed feature name"))
		
		when_generateUnitTests()
		
		then_theFeatureFromWhichContentIsGeneratedShouldBe(feature(name: "parsed feature name"))
	}
	
	func test_shouldWriteUnitTestContentFromGenerator() {
		given_files(
			["Specification.feature"]
		)
		given_thatUnitTestGeneratorReturns("unit test content")
		
		when_generateUnitTests()
		
		then_theUnitTestFileContentShouldBe("unit test content")
	}
	
	// MARK: - givens, whens and thens
	
	private func given_zeroFiles() {
		given_files(
			[]
		)
	}
	
	private func given_files(_ files: [String]) {
		mockFileSystem.filesToReturn = files
	}
	
	private func given_fileContent(_ lines: [String]) {
		mockFileSystem.fileContentToReturn = lines
	}
	
	private func given_thatUnitTestGeneratorReturns(_ content: String) {
		mockUnitTestGenerator.generatedUnitTest = content
	}
	
	private func given_parsedFeature(_ feature: Feature) {
		mockFeatureParser.featureToReturn = feature
	}
	
	private func when_generateUnitTests(baseDirectory: String = "default") {
		let generator = TestFileWriterImplementation(
			fileSystem: mockFileSystem,
			featureParser: mockFeatureParser,
			unitTestGenerator: mockUnitTestGenerator)
		
		generator.generateUnitTestsFromFeatureFiles(baseDirectory: baseDirectory)
	}
	
	private func then_theZeroUnitTestFilesShouldBeCreated(file: StaticString = #file, line: UInt = #line) {
		then_theFollowingUnitTestFilesShouldBeCreated(
			[], file: file, line: line
		)
	}
	
	private func then_theFollowingUnitTestFilesShouldBeCreated(_ files: [String],
															   file: StaticString = #file, line: UInt = #line) {
		XCTAssertEqual(files, mockFileSystem.writtenFiles, file: file, line: line)
	}
	
	private func then_theUnitTestFileContentShouldBe(_ content: String,
													 file: StaticString = #file, line: UInt = #line) {
		XCTAssertEqual(mockFileSystem.lastWrittenContent, content, file: file, line: line)
	}
	
	private func then_theFeatureFromWhichContentIsGeneratedShouldBe(_ feature: Feature,
																	file: StaticString = #file, line: UInt = #line) {
		XCTAssertEqual(mockUnitTestGenerator.lastParsedFeature, feature, file: file, line: line)
	}
	
	private func then_linesFromWhichFeatureIsParsedShouldBe(_ lines: [String],
															file: StaticString = #file, line: UInt = #line) {
		XCTAssertEqual(mockFeatureParser.parsedLines, lines, file: file, line: line)
	}
	
	private func then_pathFromWhichFeatureIsParsedShouldBe(_ path: String,
														   file: StaticString = #file, line: UInt = #line) {
		XCTAssertEqual(mockFeatureParser.parsedPath, path, file: file, line: line)
	}
}
