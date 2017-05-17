//
//  TestUnitTestFiles.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import XCTest
@testable import SwiftSpec

class GeneratedUnitTestFilesTests : TestFileGenerationBase {

	var mockFileSystem: MockFileSystem!
	var mockFeatureParser: MockFeatureParser!
	var mockUnitTestGenerator: MockUnitTestGenerator!
	
	override func setUp() {
		super.setUp()
		
		mockFileSystem = MockFileSystem()
		mockFeatureParser = MockFeatureParser()
		mockUnitTestGenerator = MockUnitTestGenerator()
		
		given_parsedFeature(Feature(title: "default feature"))
	}
	
	override func tearDown() {
		mockFileSystem = nil
		mockFeatureParser = nil
		mockUnitTestGenerator = nil
		
		super.tearDown()
	}

	// MARK:
	// MARK: created files

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
			["/base/directory/SpecificationTests.swift"]
		)
	}

	func test_twoFeatureFiles() {
		given_files(
			["One.feature",
			 "Two.feature"]
		)
		
		when_generateUnitTests(baseDirectory: "/base/directory")
		
		then_theFollowingUnitTestFilesShouldBeCreated(
			["/base/directory/OneTests.swift",
			 "/base/directory/TwoTests.swift"]
		)
	}

	// MARK:
	// MARK: integrations

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
		given_parsedFeature(Feature(title: "parsed feature title"))
		
		when_generateUnitTests()

		then_theFeatureFromWhichContentIsGeneratedShouldBe(Feature(title: "parsed feature title"))
	}
	
	func test_shouldWriteUnitTestContentFromGenerator() {
		given_files(
			["Specification.feature"]
		)
		given_thatUnitTestGeneratorReturns("unit test content")
		
		when_generateUnitTests()
		
		then_theUnitTestFileContentShouldBe("unit test content")
	}
	
	// MARK:
	// MARK: givens, whens and thens

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
		
		let t = Date.init(timeIntervalSinceReferenceDate: TimeInterval(0))
		generator.generateUnitTestsFromFeatureFiles(baseDirectory: baseDirectory, timestamp: t)
	}

	private func then_theZeroUnitTestFilesShouldBeCreated() {
		then_theFollowingUnitTestFilesShouldBeCreated(
			[]
		)
	}

	private func then_theFollowingUnitTestFilesShouldBeCreated(_ files: [String]) {
		XCTAssertEqual(files, mockFileSystem.writtenFiles)
	}
	
	private func then_theUnitTestFileContentShouldBe(_ content: String) {
		XCTAssertEqual(mockFileSystem.lastWrittenContent, content)
	}
	
	private func then_theFeatureFromWhichContentIsGeneratedShouldBe(_ feature: Feature) {
		XCTAssertEqual(mockUnitTestGenerator.lastParsedFeature, feature)
	}

	private func then_linesFromWhichFeatureIsParsedShouldBe(_ lines: [String]) {
		XCTAssertEqual(mockFeatureParser.parsedLines, lines)
	}
}
