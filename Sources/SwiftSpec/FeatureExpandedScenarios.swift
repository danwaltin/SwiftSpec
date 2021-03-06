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
//  FeatureExpandedScenarios.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-08-07.
//
// ------------------------------------------------------------------------

import GherkinSwift

extension Feature {
	func expandedScenarios() -> [Scenario] {
		return scenarios.flatMap { $0.expand() }
	}
}

extension Scenario {
	func expand() -> [Scenario] {
		let shouldExpand = isScenarioOutline && hasExampleRows()
		if !shouldExpand {
			return [self]
		}

		return examples.flatMap { examples in
			namesAndPlaceholders(from: examples, scenarioName: name)
				.map { t in
					clone(withName: t.name, examplesRow: t.row)}}
	}
	
	private func namesAndPlaceholders(from examples: ScenarioOutlineExamples, scenarioName: String) -> [(name: String, row: TableRow)] {
		let examplesName = examples.name.count == 0 ? "" : "_" + examples.name
		var names = [(String, TableRow)]()
		if let table = examples.table {
			for (index, row) in table.rows.enumerated()  {
				names.append(("\(scenarioName)\(examplesName)_\(index)", row))
			}
		}

		return names
	}
	
	private func hasExampleRows() -> Bool {
		var rows = [TableRow]()
		for examples in examples {
			if let table = examples.table {
				rows.append(contentsOf: table.rows)
			}
		}
		
		return rows.count > 0
	}
	
	private func clone(withName newName: String, examplesRow row: TableRow) -> Scenario {
		return Scenario(name: newName,
						description: description,
						tags: tags,
						location: location,
						steps: steps.map { $0.replacePlaceholders(from: row)},
						examples: [],
						localizedKeyword: localizedKeyword)
	}
}

extension Step {
	func replacePlaceholders(from examplesRow: TableRow) -> Step {
		return  Step(
			type,
			text.replacePlaceHolders(from: examplesRow),
			location: location,
			tableParameter: replacePlaceHolders(in: tableParameter, from: examplesRow),
			docStringParameter: nil,
			localizedKeyword: localizedKeyword)
	}
	
	private func replacePlaceHolders(in table: Table?, from examplesRow: TableRow) -> Table? {
		guard let table = table else {
			return nil
		}

		return table.replacePlaceHolders(from: examplesRow)
	}
}

extension Table {
	func replacePlaceHolders(from examplesRow: TableRow) -> Table {
		let newRows = rows.map { $0.replacePlaceHolders(from: examplesRow) }
		let newHeader = header.replacePlaceHolders(from: examplesRow)
		
		return Table(header: newHeader,
					 rows: newRows,
					 headerLocation: header.location)
	}
}

extension TableRow {
	func replacePlaceHolders(from examplesRow: TableRow) -> TableRow {
		let newCells = cells.map { $0.replacePlaceHolders(from: examplesRow)}

		return TableRow(cells: newCells,
						location: location)
	}
}

extension TableCell {
	func replacePlaceHolders(from examplesRow: TableRow) -> TableCell {
		return TableCell(value: value.replacePlaceHolders(from: examplesRow),
						 location: location,
						 header: header.replacePlaceHolders(from: examplesRow))
	}
}

extension String {
	func replacePlaceHolders(from examplesRow: TableRow) -> String {
		
		var newText = self
		
		for cell in examplesRow.cells {
			let column = cell.header
			let placeHolder = "<\(column)>"
			
			if self.contains(placeHolder) {
				let value = "\(examplesRow[column].value)"
				newText = newText.replacingOccurrences(of: placeHolder, with: value)
			}
		}
		
		return newText
	}

}
