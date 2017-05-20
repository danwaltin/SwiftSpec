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
//  Table.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-29.
//
// ------------------------------------------------------------------------

public struct Table : Equatable {
	public let columns: [String]
	public let rows: [TableRow]
	
	public init(columns: [String]) {
		self.columns = columns
		rows = []
	}
	
	private init(columns: [String], rows: [TableRow]) {
		self.columns = columns
		self.rows = rows
	}
	
	public func addingRow(cells: [String]) -> Table {
		var copyOfCurrentRows = self.rows
		copyOfCurrentRows.append(tableRow(cells))
		
		return Table(columns: self.columns, rows: copyOfCurrentRows)
	}
	
	private func tableRow(_ cellValues: [String]) -> TableRow {
		var newRowContent = [String: String]()
		for i in 0...columns.count-1 {
			newRowContent[columns[i]] = cellValues[i]
		}
		
		return TableRow(cells: newRowContent)
	}
}

public func ==(_ lhs: Table, _ rhs: Table) -> Bool {
	return lhs.columns == rhs.columns && lhs.rows == rhs.rows
}
