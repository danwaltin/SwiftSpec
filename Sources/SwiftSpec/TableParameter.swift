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
//  TableParameter.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-29.
//
// ------------------------------------------------------------------------

public struct TableParameter : Equatable {
	public let columns: [String]
	public let rows: [TableParameterRow]
	
	public init(columns: [String]) {
		self.columns = columns
		rows = []
	}
	
	private init(columns: [String], rows: [TableParameterRow]) {
		self.columns = columns
		self.rows = rows
	}
	
	public func addingRow(cells: [String]) -> TableParameter {
		var copyOfCurrentRows = self.rows
		copyOfCurrentRows.append(tableRow(cells))
		
		return TableParameter(columns: self.columns, rows: copyOfCurrentRows)
	}

	public func addingRow(cells: [String: String]) -> TableParameter {
		assertValidAddedColumns(Array(cells.keys))

		var copyOfCurrentRows = self.rows
		copyOfCurrentRows.append(TableParameterRow(cells: cells))

		return TableParameter(columns: self.columns, rows: copyOfCurrentRows)
	}

	private func tableRow(_ cellValues: [String]) -> TableParameterRow {
		var newRowContent = [String: String]()
		for i in 0...columns.count-1 {
			newRowContent[columns[i]] = cellValues[i]
		}
		
		return TableParameterRow(cells: newRowContent)
	}
	
	private func assertValidAddedColumns(_ addedColumns: [String]) {
		assert(addedColumns.count == columns.count, "Wrong number of added columns. Expected \(columns.count) but got \(addedColumns.count)")

		for added in addedColumns {
			assert(columns.contains(added), "Added column '\(added)' not present in table. Valid columns: \(columns)")
		}
	}
}
