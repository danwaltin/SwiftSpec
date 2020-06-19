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
//  ScenarioContentUnitTestTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-04.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
import GherkinSwift

class ScenarioContentUnitTestTests : TestFileGenerationBase {
	
	var scenarioToUse: Scenario!
	
	// MARK: - Scenario test method name
	func test_oneWordTitle() {
		given_scenarioWithTitle("Title")
		
		then_scenarioShouldBe([
			"func testTitleTests() {",
			"}"]
		)
	}
	
	func test_twoWordsTitle() {
		given_scenarioWithTitle("one two")
		
		then_scenarioShouldBe([
			"func testOneTwoTests() {",
			"}"]
		)
	}
	
	func test_scenarioWithDashInTitle() {
		given_scenarioWithTitle("Scenario-title")
		
		then_scenarioShouldBe([
			"func testScenarioTitleTests() {",
			"}"]
		)
	}
	
	func test_scenarioWithSwedishCharacters_ShouldReplaceWithAscii() {
		given_scenarioWithTitle("Xå Xä Xö Åx Äx Öx")
		
		then_scenarioShouldBe([
			"func testXaXaXoAxAxOxTests() {",
			"}"]
		)
	}
	
	func test_ignoredScenario() {
		given_scenarioWithTitle("Title", hasIgnoreTag: true)
		
		then_scenarioShouldBe([
			"func IGNORE_testTitleTests() {",
			"scenarioContext.tags = [\"\(ignoreTag)\"]",
			"}"]
		)
	}
	
	// MARK: - Tags
	func test_scenarioWithZeroTags() {
		given_scenario(
			scenario("title", tags: []
			)
		)
		
		then_scenarioShouldBe([
			"func testTitleTests() {",
			"}"]
		)
	}

	func test_scenarioWithOneTag() {
		given_scenario(
			scenario("title", tags: [
				"tag"]
			)
		)
		
		then_scenarioShouldBe([
			"func testTitleTests() {",
			"scenarioContext.tags = [\"tag\"]",
			"}"]
		)
	}

	func test_scenarioWithTwoTags() {
		given_scenario(
			scenario("title", tags: [
				"one",
				"two"]
			)
		)
		
		then_scenarioShouldBe([
			"func testTitleTests() {",
			"scenarioContext.tags = [\"one\", \"two\"]",
			"}"]
		)
	}

	// MARK: - Steps
	func test_scenarioWithOneGivenStep() {
		given_scenario(
			scenario("title", [
				given("something")]
			)
		)
		
		then_scenarioShouldBe([
			"func testTitleTests() {",
			"do {",
			"try testRunner.executeStep(.Given, \"something\")",
			"} catch {",
			"XCTFail(\"\\(error)\")",
			"}",
			"}"]
		)
	}

	func test_scenarioWithOneWhenStep() {
		given_scenario(
			scenario("title", [
				when("something")]
			)
		)
		
		then_scenarioShouldBe([
			"func testTitleTests() {",
			"do {",
			"try testRunner.executeStep(.When, \"something\")",
			"} catch {",
			"XCTFail(\"\\(error)\")",
			"}",
			"}"]
		)
	}

	func test_scenarioWithOneThenStep() {
		given_scenario(
			scenario("title", [
				then("something")]
			)
		)
		
		then_scenarioShouldBe([
			"func testTitleTests() {",
			"do {",
			"try testRunner.executeStep(.Then, \"something\")",
			"} catch {",
			"XCTFail(\"\\(error)\")",
			"}",
			"}"]
		)
	}

	func test_scenarioWithGivenWhenThenSteps() {
		given_scenario(
			scenario("title", [
				given("a"),
				when("b"),
				then("c")]
			)
		)
		
		then_scenarioShouldBe([
			"func testTitleTests() {",
			"do {",
			"try testRunner.executeStep(.Given, \"a\")",
			"try testRunner.executeStep(.When, \"b\")",
			"try testRunner.executeStep(.Then, \"c\")",
			"} catch {",
			"XCTFail(\"\\(error)\")",
			"}",
			"}"]
		)
	}

	// MARK: - Steps with table arguments
	func test_scenarioWithGivenStep_withTableArgumentWithOneRow() {
		given_scenario(
			scenario("title", [
				given("a", table("col", "r1c1"))]
			)
		)

		then_scenarioShouldBe([
			"func testTitleTests() {",
			"do {",
			"let table1 = Table(columns: [\"col\"])",
			".addingRow(cells: [\"r1c1\"])",
			"try testRunner.executeStep(.Given, \"a\", table1)",
			"} catch {",
			"XCTFail(\"\\(error)\")",
			"}",
			"}"]
		)
	}

	func test_scenarioWithWhenStep_withTableArgumentWithTwoRows() {
		given_scenario(
			scenario("title", [
				when("a", table("col", "r1c1", "r2c1"))]
			)
		)
		
		then_scenarioShouldBe([
			"func testTitleTests() {",
			"do {",
			"let table1 = Table(columns: [\"col\"])",
			".addingRow(cells: [\"r1c1\"])",
			".addingRow(cells: [\"r2c1\"])",
			"try testRunner.executeStep(.When, \"a\", table1)",
			"} catch {",
			"XCTFail(\"\\(error)\")",
			"}",
			"}"]
		)
	}

	func test_scenarioWithThenStep_withTableArgumentWithTwoColumns() {
		given_scenario(
			scenario("title", [
				then("a", table("c1", "c2", "r1c1", "r1c2"))]
			)
		)
		
		then_scenarioShouldBe([
			"func testTitleTests() {",
			"do {",
			"let table1 = Table(columns: [\"c1\", \"c2\"])",
			".addingRow(cells: [\"r1c1\", \"r1c2\"])",
			"try testRunner.executeStep(.Then, \"a\", table1)",
			"} catch {",
			"XCTFail(\"\\(error)\")",
			"}",
			"}"]
		)
	}

	func test_scenarioWithThreeSteps_firstAndLastWithTableParameters() {
		given_scenario(
			scenario("title", [
				given("g", table("c1", "v1")),
				when("w"),
				then("t", table("c2", "v2"))]
			)
		)
		
		then_scenarioShouldBe([
			"func testTitleTests() {",
			"do {",
			"let table1 = Table(columns: [\"c1\"])",
			".addingRow(cells: [\"v1\"])",
			"try testRunner.executeStep(.Given, \"g\", table1)",
			"try testRunner.executeStep(.When, \"w\")",
			"let table2 = Table(columns: [\"c2\"])",
			".addingRow(cells: [\"v2\"])",
			"try testRunner.executeStep(.Then, \"t\", table2)",
			"} catch {",
			"XCTFail(\"\\(error)\")",
			"}",
			"}"]
		)
	}

	// MARK: - givens, whens thens
	func given_scenarioWithTitle(_ title: String, hasIgnoreTag: Bool = false) {
		given_scenario(scenario(title, hasIgnoreTag))
	}
	
	private func given_scenario(_ scenario: Scenario) {
		self.scenarioToUse = scenario
	}
	
	private func then_scenarioShouldBe(_ lines: [String], file: StaticString = #file, line: UInt = #line) {
		let expected = stringWithLines(lines)
		let actual = instanceToTest().scenario(scenario: scenarioToUse)
		
		XCTAssertEqual(actual, expected, file: file, line: line)
	}
	
	// MARK: - Factory methods
	
	private func instanceToTest() -> XCUnitTestGenerator {
		return XCUnitTestGenerator()
	}
	
	private func scenario(_ title: String, tags: [String] = []) -> Scenario {
		return Scenario(title: title, tags: tags, steps: [])
	}

	private func scenario(_ title: String, _ steps: [Step] = []) -> Scenario {
		return scenario(title, false, steps)
	}

	private func scenario(_ title: String, _ hasIgnoreTag: Bool, _ steps: [Step] = []) -> Scenario {
		return Scenario(title: title, tags: tags(hasIgnoreTag), steps: steps)
	}
	
	private func given(_ text: String, _ table: Table? = nil) -> Step {
		return Step.given(text, table)
	}

	private func when(_ text: String, _ table: Table? = nil) -> Step {
		return Step.when(text, table)
	}

	private func then(_ text: String, _ table: Table? = nil) -> Step {
		return Step.then(text, table)
	}

	private func table(_ columnName: String, _ r1c1: String) -> Table {
		return Table(columns: [columnName]).addingRow(cells: [r1c1])
	}
	
	private func table(_ columnName: String, _ r1c1: String, _ r2c1: String) -> Table {
		return Table(columns: [columnName]).addingRow(cells: [r1c1]).addingRow(cells: [r2c1])
	}
	
	private func table(_ c1: String, _ c2: String, _ r1c1: String, _ r1c2: String) -> Table {
		return Table(columns: [c1, c2]).addingRow(cells: [r1c1, r1c2])
	}
	
	func stringWithLines(_ lines: [String]) -> String {
		var s = ""
		for line in lines {
			s = s.appendLine(line)
		}
		return s
	}
}
