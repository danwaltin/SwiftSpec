//
//  StepScanner.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-08.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

class  StepScanner {
	var text = ""
	var step: Step!
	
	var isScanningTable = false
	let tableScanner = TableScanner()

	func getStep() -> Step {
		return Step(type: step.type, text: step.text, tableParameter: tableScanner.getTableArgument())
	}
	
	func scan(line: String) {
		handleStepText(line: line)
		handleTable(line: line)
	}
	
	private func handleStepText(line: String) {
		if line.isGiven() {
			step = Step.given(line.removeKeyword(keywordGiven))
		}
		
		if line.isWhen() {
			step = Step.when(line.removeKeyword(keywordWhen))
		}
		
		if line.isThen() {
			step = Step.then(line.removeKeyword(keywordThen))
		}
	}

	private func handleTable(line: String) {
		if line.trim().isEmpty {
			return
		}

		if isScanningTable {
			tableScanner.scanLine(line: line)
			
		} else if line.isTable() {
			isScanningTable = true
			tableScanner.scanLine(line: line)
		}
	}
}
