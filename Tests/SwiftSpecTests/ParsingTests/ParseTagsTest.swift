//
//  ParseTagsTest.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-27.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import XCTest
@testable import SwiftSpec

class ParseTagsTest : TestParseBase {

	// MARK:
	// MARK: Feature tags
	func test_parseFeatureWithZeroTags_shouldHaveEmptyListOfTags() {
		when_parsingFeature([
			"Feature: feature without tags"])
		
		then_feature(shouldHaveTags: [])
	}
	
	func test_parseFeatureWithOneTag() {
		when_parsingFeature([
			"@tag",
			"Feature: title"])
		
		then_feature(shouldHaveTags: ["tag"])
	}
	
	func test_parseFeatureWithTwoTags_onOneRow() {
		when_parsingFeature([
			"@one @two",
			"Feature: title"])
		
		then_feature(shouldHaveTags: ["one", "two"])
	}

	func test_parseFeatureWithTwoTags_extraSpaceAfter() {
		when_parsingFeature([
			"@one @two   ",
			"Feature: title"])
		
		then_feature(shouldHaveTags: ["one", "two"])
	}

	func test_parseFeatureWithTwoTags_onTwoRows() {
		when_parsingFeature([
			"@one",
			"@two",
			"Feature: title"])
		
		then_feature(shouldHaveTags: ["one", "two"])
	}
	
	func test_parseFeatureWithFourTags_onTwoRows_extraSpace() {
		when_parsingFeature([
			"@one @two",
			"@three @four",
			"Feature: title"])
		
		then_feature(shouldHaveTags: ["one", "two", "three", "four"])
	}

	func test_parseFeatureWithTwoTags_extraSpaceBetween() {
		when_parsingFeature([
			"@one  @two",
			"Feature: title"])
		
		then_feature(shouldHaveTags: ["one", "two"])
	}
	
	func test_parseFeatureWithTwoTags_extraTabBetween() {
		when_parsingFeature([
			"@one\t@two",
			"Feature: title"])
		
		then_feature(shouldHaveTags: ["one", "two"])
	}
	
	// MARK:
	// MARK: Scenario tags
	func test_scenarioWithOneTag() {
		when_parsingFeature([
			"Feature: feature",
			"@tag",
			"Scenario: scenario",
			"    Then something is the result"])
		
		then_scenario(shouldHaveTags: ["tag"])
	}
	
	func test_scenarioWithTwoTags_oneRow() {
		when_parsingFeature([
			"Feature: feature",
			"@one @two",
			"Scenario: scenario",
			"    Then something is the result"])
		
		then_scenario(shouldHaveTags: ["one", "two"])
	}
	
	func test_scenarioWithTwoTags_twoRows() {
		when_parsingFeature([
			"Feature: feature",
			"@one",
			"@two",
			"Scenario: scenario",
			"    Then something is the result"])
		
		then_scenario(shouldHaveTags: ["one", "two"])
	}
	
	func test_scenarioWithTwoTags_twoExtraSpaces() {
		when_parsingFeature([
			"Feature: feature",
			"@one   @two",
			"Scenario: scenario",
			"    Then something is the result"])
		
		then_scenario(shouldHaveTags: ["one", "two"])
	}

	// MARK:
	// MARK: Scenario Outline tags
	func test_scenarioOutlineWithOneTag() {
		when_parsingFeature([
			"Feature: feature          ",
			"@tag                      ",
			"Scenario Outline: scenario",
			"    Then x                ",
			" Examples:                ",
			"    | key |               ",
			"    | one |               "])
		
		then_scenario(shouldHaveTags: ["tag"])
	}

	func test_scenarioOutlineWithOneTagTwoExamples() {
		when_parsingFeature([
			"Feature: feature          ",
			"@tag                      ",
			"Scenario Outline: scenario",
			"    Then x                ",
			" Examples:                ",
			"    | key |               ",
			"    | one |               ",
			"    | two |               "])
		
		then_scenario(0, shouldHaveTags: ["tag"])
		then_scenario(1, shouldHaveTags: ["tag"])
	}

	func test_scenarioOutlineWithTwoTags_oneRow() {
		when_parsingFeature([
			"Feature: feature          ",
			"@one @two                 ",
			"Scenario Outline: scenario",
			"    Then x                ",
			" Examples:                ",
			"    | key |               ",
			"    | one |               "])
		
		then_scenario(shouldHaveTags: ["one", "two"])
	}
	
	func test_scenarioOutlineWithTwoTags_twoRows() {
		when_parsingFeature([
			"Feature: feature          ",
			"@one                      ",
			"@two                      ",
			"Scenario Outline: scenario",
			"    Then x                ",
			" Examples:                ",
			"    | key |               ",
			"    | one |               "])
		
		then_scenario(shouldHaveTags: ["one", "two"])
	}
	
	func test_scenarioOutlineWithTwoTags_twoExtraSpaces() {
		when_parsingFeature([
			"Feature: feature          ",
			"@one   @two               ",
			"Scenario Outline: scenario",
			"    Then x                ",
			" Examples:                ",
			"    | key |               ",
			"    | one |               "])
		
		then_scenario(shouldHaveTags: ["one", "two"])
	}

	// MARK: 
	// MARK: Feature, scenario and scenario outline tags
	func test_featureWithThreeTags_andTwoScenariosWithThreeTagsEach() {
		when_parsingFeature([
			"@f1 @f2              ",
			"@f3                  ",
			"Feature: f           ",
			"                     ",
			"@s1.1                ",
			"@s1.2 @s1.3          ",
			"Scenario: s1         ",
			"    Then x           ",
			"                     ",
			"@s2.1 @s2.2          ",
			"@s2.3                ",
			"Scenario: s2         ",
			"    Then x           ",
			"                     ",
			"@s3.1 @s3.2          ",
			"@s3.3                ",
			"Scenario Outline: s3 ",
			"    Then x           ",
			" Examples:           ",
			"    | key |          ",
			"    | one |          ",
			"    | two |          "])
		
		then_feature(shouldHaveTags: ["f1", "f2", "f3"])
		then_scenario(0, shouldHaveTags: ["s1.1", "s1.2", "s1.3"])
		then_scenario(1, shouldHaveTags: ["s2.1", "s2.2", "s2.3"])
		then_scenario(2, shouldHaveTags: ["s3.1", "s3.2", "s3.3"])
		then_scenario(3, shouldHaveTags: ["s3.1", "s3.2", "s3.3"])
	}
	
	// MARK:
	// MARK: Givens, whens, thens

	private func then_feature(shouldHaveTags tags: [String]) {
		XCTAssertEqual(actualFeature.tags, tags)
	}

	func then_scenario(_ index: Int = 0, shouldHaveTags tags: [String]) {
		XCTAssertEqual(scenario(at: index).tags, tags)
	}
}
