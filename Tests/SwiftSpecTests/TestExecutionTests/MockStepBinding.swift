//
//  MockStepBinding.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-09.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

@testable import SwiftSpec

class MockStepBinding : StepBinding {

	var hasBeenExecuted = false
	var passedParameters: BindingsParameters?
	let matchesText: Bool
	let evaluatedValues: [String]
	
	init(matchesText: Bool = true, evaluatedValues: [String] = []) {
		self.matchesText = matchesText
		self.evaluatedValues = evaluatedValues
	}
	
	func execute(_ parameters: BindingsParameters) {
		hasBeenExecuted = true
		passedParameters = parameters
	}
	
	func matches(text: String) -> Bool {
		return matchesText
	}
	
	func matchParameters(text: String) -> [String] {
		return evaluatedValues
	}

}
