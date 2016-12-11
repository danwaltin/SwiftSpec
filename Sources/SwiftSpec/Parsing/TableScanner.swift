//
//  TableScanner.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-31.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

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
		var v = line.asNSString().components(separatedBy: tableSeparator)
		v.removeLast()
		v.remove(at: 0)
		
		var items = [String]()
		for cell in v {
			items.append(cell.trim())
		}
		
		return items
	}
	
}
