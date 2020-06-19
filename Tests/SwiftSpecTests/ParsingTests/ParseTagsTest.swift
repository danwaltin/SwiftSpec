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
//  ParseTagsTest.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-27.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec

class ParseTagsTest : TestParseBase {

	// MARK: - Feature tags
	func test_parseFeatureWithZeroTags_shouldHaveEmptyListOfTags() {
		when_parsingFeature([
			"Feature: feature without tags"])
		
		then_feature(shouldHaveTags: [])
	}
	
	func test_parseFeatureWithOneTag() {
		when_parsingFeature([
			"@tag",
			"Feature: name"])
		
		then_feature(shouldHaveTags: ["tag"])
	}
	
	func test_parseFeatureWithTwoTags_onOneRow() {
		when_parsingFeature([
			"@one @two",
			"Feature: name"])
		
		then_feature(shouldHaveTags: ["one", "two"])
	}

	func test_parseFeatureWithTwoTags_extraSpaceAfter() {
		when_parsingFeature([
			"@one @two   ",
			"Feature: name"])
		
		then_feature(shouldHaveTags: ["one", "two"])
	}

	func test_parseFeatureWithTwoTags_onTwoRows() {
		when_parsingFeature([
			"@one",
			"@two",
			"Feature: name"])
		
		then_feature(shouldHaveTags: ["one", "two"])
	}
	
	func test_parseFeatureWithFourTags_onTwoRows_extraSpace() {
		when_parsingFeature([
			"@one @two",
			"@three @four",
			"Feature: name"])
		
		then_feature(shouldHaveTags: ["one", "two", "three", "four"])
	}

	func test_parseFeatureWithTwoTags_extraSpaceBetween() {
		when_parsingFeature([
			"@one  @two",
			"Feature: name"])
		
		then_feature(shouldHaveTags: ["one", "two"])
	}
	
	func test_parseFeatureWithTwoTags_extraTabBetween() {
		when_parsingFeature([
			"@one\t@two",
			"Feature: name"])
		
		then_feature(shouldHaveTags: ["one", "two"])
	}
	
	// MARK: - Scenario tags
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

	// MARK: - Scenario Outline tags
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

	// MARK: - Feature, scenario and scenario outline tags
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
	
	// MARK: - Givens, whens, thens

	private func then_feature(shouldHaveTags tags: [String]) {
		XCTAssertEqual(actualFeature.tags, tags)
	}

	func then_scenario(_ index: Int = 0, shouldHaveTags tags: [String]) {
		XCTAssertEqual(scenario(at: index).tags, tags)
	}
}
