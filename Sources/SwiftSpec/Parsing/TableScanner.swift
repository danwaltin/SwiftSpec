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
//  TableScanner.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-31.
//
// ------------------------------------------------------------------------


class TableScanner {
	
	var hasScannedColumns = false
	var columns: [String] = []
	var rows: [[String]] = []
	
	var hasTable = false
	
	func scanLine(line: String) {
		hasTable = true
		
		if hasScannedColumns {
			addRow(line)
		} else {
			createColumns(line)
		}
	}

	func getTableArgument() -> Table? {
		if !hasTable {
			return nil
		}
		
		var t = Table(columns: columns)
		for row in rows {
			t = t.addingRow(cells: row)
		}

		return t
	}

	private func createColumns(_ line: String) {
		columns = lineItems(line)
		hasScannedColumns = true
	}

	private func addRow(_ line: String) {
		rows.append(lineItems(line))
	}
	
	private func lineItems(_ line: String) -> [String] {
		var v = line.components(separatedBy: tableSeparator)
		v.removeLast()
		v.remove(at: 0)
		
		var items = [String]()
		for cell in v {
			items.append(cell.trim())
		}
		
		return items
	}
	
}
