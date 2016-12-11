//
//  Table.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-29.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

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
