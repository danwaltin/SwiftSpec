//
//  ScanningStringExtension.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-08.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

let tagToken = "@"
let keywordFeature = "Feature:"
let keywordScenarioOutline = "Scenario Outline:"
let keywordScenario = "Scenario:"
let keywordExamples = "Examples:"
let keywordGiven = "Given"
let keywordWhen = "When"
let keywordThen = "Then"
let tableSeparator = "|"

extension String {
	func beginsWithKeyword(_ keyword: String) -> Bool {
		return trim().hasPrefix(keyword)
	}
	
	func removeKeyword(_ keyword: String) -> String {
		let copy = deleteText(keyword)
		return copy.trim()
	}
	
	func isTag() -> Bool {
		return hasPrefix(tagToken)
	}
	
	func isFeature() -> Bool {
		return beginsWithKeyword(keywordFeature)
	}
	
	func isScenarioOutline() -> Bool {
		return beginsWithKeyword(keywordScenarioOutline)
	}

	func isScenario() -> Bool {
		return beginsWithKeyword(keywordScenario)
	}
	
	func isExamples() -> Bool {
		return beginsWithKeyword(keywordExamples)
	}
	
	func isGiven() -> Bool {
		return beginsWithKeyword(keywordGiven)
	}
	
	func isWhen() -> Bool {
		return beginsWithKeyword(keywordWhen)
	}
	
	func isThen() -> Bool {
		return beginsWithKeyword(keywordThen)
	}
	
	func isStep() -> Bool {
		return isGiven() || isWhen() || isThen()
	}
	
	func isTable() -> Bool {
		return beginsWithKeyword(tableSeparator)
	}
}
