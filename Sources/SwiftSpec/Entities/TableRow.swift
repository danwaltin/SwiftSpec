//
//  TableRow.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-12-11.
//
//

import Foundation

public struct TableRow : Equatable {
	
	internal let cells: [String: String]
	
	internal init(cells: [String: String]) {
		self.cells = cells
	}
	
	public subscript(column: String) -> String {
		return cells[column]!
	}
}

public func ==(_ lhs: TableRow, _ rhs: TableRow) -> Bool {
	return lhs.cells == rhs.cells
}
