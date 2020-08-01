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
//  XCUnitTestGenerator.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//
// ------------------------------------------------------------------------
import Foundation
import GherkinSwift

let ignoreTag = "ignore"

class XCUnitTestGenerator: UnitTestGenerator {
	
	func generateUnitTest(feature: Feature) -> String {
		var t = ""
		t = t.appendLine(header())
		t = t.appendLine(featureClass(feature: feature))
		t = t.appendLine(setupAndTearDown(feature: feature))
		for s in feature.scenarios {
			t = t.appendLine(scenario(scenario: s))
		}
		t = t.appendLine(footer())
		return t
	}
	
	func header() -> String {
		return lines([
			"//",
			"// AUTOGENERATED FILE",
			"// This code was generated by SwiftSpec",
			"//",
			"// Changes to this file may cause",
			"// incorrect behaviour and will be lost",
			"// if the file is regenerated.",
			"//",
			"",
			"import XCTest",
			"import SwiftSpec",
			""])
	}
	
	func featureClass(feature: Feature) -> String {
		return "class \(ignorePrefix(feature))\(testEntityName(feature))Tests\(superClass(feature)) {"
	}

	func setupAndTearDown(feature: Feature) -> String {
		return lines([
			"var testRunner:TestRunner!",
			"var scenarioContext:ScenarioContext!",
			"",
			"override func setUp() {",
			"super.setUp()",
			"scenarioContext = ScenarioContextImplementation()",
			"scenarioContext.featureTags = \(featureTags(feature))",
			"testRunner = TestRunner(scenarioContext: scenarioContext)",
			"}",
			"",
			"override func tearDown() {",
			"testRunner = nil",
			"scenarioContext = nil",
			"super.tearDown()",
			"}",
			""])
	}
	
	func scenario(scenario: Scenario) -> String {
		return "func \(ignorePrefix(scenario))test\(testEntityName(scenario))Tests() {\n" +
			scenarioTags(scenario) +
			steps(scenario) +
			"}"
	}
	
	private func steps(_ scenario: Scenario) -> String {
		if scenario.steps.count == 0 {
			return ""
		}
		
		var steps = ""
		steps += line("do {")
		var tableCounter = 0
		for s in scenario.steps {
			if s.tableParameter != nil {
				tableCounter += 1
			}
			steps += step(s, tableCounter: tableCounter)
		}
		
		steps += line("} catch {")
		steps += line("XCTFail(\"\\(error)\")")
		steps += line("}")
		
		return steps
	}
	
	private func step(_ step: Step, tableCounter: Int) -> String {
		let type = ".\(step.type)"
		let text = "\"\(step.text)\""

		if step.tableParameter == nil {
			return line(executeStep("\(type), \(text)"))
		}

		let tableParameterName = "table\(tableCounter)"
		var tableParameter = tableDeclaration(step.tableParameter!, tableParameterName)
		tableParameter += line(executeStep("\(type), \(text), \(tableParameterName)"))
		return tableParameter
	}
	
	private func tableDeclaration(_ table: Table, _ parameterName: String) -> String {
		var t = line("let \(parameterName) = TableParameter(columns: \(tableParameterColumns(table)))")
		for row in table.rows {
			t += line(".addingRow(cells: \(tableRowCells(table, row)))")
		}
		
		return t
	}
	
	private func tableParameterColumns(_ table: Table) -> String {
		return arrayParameter(table.header.cells.map { $0.value })
	}
	
	private func tableRowCells(_ table: Table, _ row: TableRow) -> String {
		return arrayParameter(row.cells.map {$0.value})
	}
	
	private func executeStep(_ parameters: String) -> String {
		return "try testRunner.executeStep(\(parameters))"
	}
	
	func footer() -> String {
		return "}"
	}

	private func lines(_ lines: [String]) -> String {
		return lines.reduce("") {$0.appendLine($1)}
	}
	
	private func line(_ s: String) -> String {
		return s.appendLine()
	}
	
	private func testEntityName(_ entity: HasName) -> String {
		return replaceSpecialCharacters(entity.name).camelCaseify()
	}
	
	private func ignorePrefix(_ entity: Taggable) -> String {
		if containsIgnore(tags: entity.tags) {
			return "IGNORE_"
		}
		return ""
	}

	private func superClass(_ feature: Feature) -> String {
		if containsIgnore(tags: feature.tags) {
			return " : Ignore"
		}
		return " : XCTestCase"
	}

	private func containsIgnore(tags: [Tag]) -> Bool {
		return tags.map {$0.name}.contains(ignoreTag)
	}
	
	private func featureTags(_ taggable: Taggable) -> String {
		if taggable.tags.count == 0 {
			return "[]"
		}
		
		return "\(tagsArray(taggable))"
	}

	private func scenarioTags(_ taggable: Taggable) -> String {
		if taggable.tags.count == 0 {
			return ""
		}

		return line("scenarioContext.tags = \(tagsArray(taggable))")
	}
	
	private func tagsArray(_ taggable: Taggable) -> String {
		return arrayParameter(taggable.tags.map { $0.name})
	}
	
	private func arrayParameter(_ items: [String]) -> String {
		let itemsAsStrings = items.map {"\"" + $0 + "\""}
		return "[" + itemsAsStrings.joined(separator: ", ") + "]"
	}
		
	private func headerTimestampAsString(timestamp: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
		return formatter.string(from: timestamp)
	}
	
	private func replaceSpecialCharacters(_ input: String) -> String {
		let replacements = [
			"å": "a",
			"ä": "a",
			"ö": "o",
			"Å": "A",
			"Ä": "A",
			"Ö": "O",
			"-": " "]
		
		return string(fromString: input, byReplacingCharacters: replacements)
	}

	private func string(fromString: String, byReplacingCharacters replacements: [String: String]) -> String {
		var toString = fromString
		
		for (from, to) in replacements {
			toString = toString.replacingOccurrences(of: from, with: to)
		}
		
		return toString
	}
}
