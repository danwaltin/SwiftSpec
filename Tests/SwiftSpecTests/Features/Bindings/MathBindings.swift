//
//  File.swift
//  
//
//  Created by Dan Waltin on 2020-08-09.
//

import SwiftSpec
import XCTest

class BasicFeatureBindings: Bindings {
	
	override func defineBindings() {
		addBinding(stepText: "adding '(.*)' and '(.*)'") {
			let arg1 = Int($0.matchedParameters[0])!
			let arg2 = Int($0.matchedParameters[1])!
			
			self.scenarioContext["result"] = arg1 + arg2
		}
		
		addBinding(stepText: "that operand1 '(.*)' has been entered") {
			let operand = Int($0.matchedParameters[0])!
			self.scenarioContext["operand1"] = operand
		}

		addBinding(stepText: "that operand2 '(.*)' has been entered") {
			let operand = Int($0.matchedParameters[0])!
			self.scenarioContext["operand2"] = operand
		}

		addBinding(stepText: "entering operator '(.*)'") {
			let enteredOperator = $0.matchedParameters[0]

			let operand1: Int = self.scenarioContext.get("operand1")
			let operand2: Int = self.scenarioContext.get("operand2")
			
			switch enteredOperator {
			case "add":
				self.scenarioContext["result"] = operand1 + operand2
				return
			case "subtract":
				self.scenarioContext["result"] = operand1 - operand2
				return
			default:
				XCTFail("Operator '\(enteredOperator)' not supported")
			}
		}

		addBinding(stepText: "the result should be '(.*)'") {
			let result = Int($0.matchedParameters[0])!
			let actual: Int = self.scenarioContext.get("result")
			
			XCTAssertEqual(actual, result)
		}
	}
}
