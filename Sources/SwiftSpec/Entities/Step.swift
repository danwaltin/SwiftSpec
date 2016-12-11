//
//  Step.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-06.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import Foundation

public enum StepType {
	case Given
	case When
	case Then
}

struct Step : Equatable {
	let type: StepType
	let text: String
	let tableParameter: Table?
	
	static func given(_ text: String, _ table: Table? = nil) -> Step {
		return Step(type: .Given, text: text, tableParameter: table)
	}

	static func when(_ text: String, _ table: Table? = nil) -> Step {
		return Step(type: .When, text: text, tableParameter: table)
	}

	static func then(_ text: String, _ table: Table? = nil) -> Step {
		return Step(type: .Then, text: text, tableParameter: table)
	}

	init(type: StepType, text: String, tableParameter: Table? = nil) {
		self.type = type
		self.text = text
		self.tableParameter = tableParameter
	}
}

func == (lhs: Step, rhs: Step) -> Bool {
	return
		lhs.type == rhs.type &&
		lhs.text == rhs.text &&
		lhs.tableParameter == rhs.tableParameter
}
