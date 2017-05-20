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
//  ScenarioOutlineScanner.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-08-08.
//
// ------------------------------------------------------------------------

class ScenarioOutlineScanner : ScenarioScanner {
	var isScanningExamples = false
	let tableScanner = TableScanner()
	
	override func scan(line: String) {
		if line.isScenarioOutline() {
			title = line.removeKeyword(keywordScenarioOutline)
			
		} else if isScanningExamples && !line.trim().isEmpty{
			tableScanner.scanLine(line: line)
			
		} else if line.isExamples() {
			isScanningExamples = true
			
		} else {
			super.scan(line: line)
		}
	}
	
	override func getScenarios() -> [Scenario] {
		var titles = scenarioTitles()
		
		var scenarios = [Scenario]()
		
		var index = 0
		let examplesTable = tableScanner.getTableArgument()!
		for examplesRow in examplesTable.rows {
			let newSteps = steps().map {
				replacePlaceHolders($0, examplesRow)
			}
			
			scenarios.append(Scenario(title: titles[index], tags: scenarioTags, steps: newSteps))
			index += 1
		}
		
		return scenarios
	}

	private func replacePlaceHolders(_ step: Step, _ examplesRow: TableRow) -> Step {
		return Step(
			type: step.type,
			text: replacePlaceHolders(step.text, examplesRow),
			tableParameter: replacePlaceHolders(step.tableParameter, examplesRow))
	}
	
	private func scenarioTitles() -> [String] {
		let indices = 0...(tableScanner.rows.count-1)
		return indices.map {"\(title)_\($0)"}
	}

	private func replacePlaceHolders(_ table: Table?, _ examplesRow: TableRow) -> Table? {
		if table == nil {
			return nil
		}
		
		var t = Table(columns: replacePlaceHolders(table!.columns, examplesRow))
		for row in table!.rows {
			t = t.addingRow(cells: replacePlaceHolders(row, examplesRow))
		}
		return t
	}
	
	private func replacePlaceHolders(_ row: TableRow, _ examplesRow: TableRow) -> [String] {
		let rowCellValues = [String](row.cells.values)
		return replacePlaceHolders(rowCellValues, examplesRow)
	}
	
	private func replacePlaceHolders(_ items: [String], _ examplesRow: TableRow) -> [String] {
		var replaced = [String]()
		for item in items {
			replaced.append(replacePlaceHolders(item, examplesRow))
		}
		
		return replaced
	}
	
	private func replacePlaceHolders(_ value: String, _ examplesRow: TableRow) -> String {
		
		var newText = value
		
		for column in examplesRow.cells.keys {
			let placeHolder = "<\(column)>"
			
			if value.contains(placeHolder) {
				let value = "\(examplesRow[column])"
				newText = newText.replacingOccurrences(of: placeHolder, with: value)
			}
		}
		
		return newText
	}
}
