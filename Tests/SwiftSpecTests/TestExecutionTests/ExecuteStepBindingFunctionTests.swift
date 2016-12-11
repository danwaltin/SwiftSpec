//
//  ExecuteStepBindingFunctionTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-23.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import XCTest
@testable import SwiftSpec

class ExecuteStepBindingFunctionTests : XCTestCase {

	func test_functionIsExecuted() {
		var hasBeenExecuted = false
		let s = step {_ in 
			hasBeenExecuted = true
		}
		try! s.execute(BindingsParameters())
		
		XCTAssertTrue(hasBeenExecuted)
	}

	func test_bindingsParametersAreSet() {
		var parameters: BindingsParameters?
		let s = step {
			parameters = $0
		}
		try! s.execute(BindingsParameters(table: Table(columns: ["c"])))
		
		XCTAssertEqual(parameters, BindingsParameters(table: Table(columns: ["c"])))
	}

	// MARK:
	// MARK: Factory methods
	private func step(_ function: @escaping (BindingsParameters) -> ()) -> StepBindingImplementation {
		return StepBindingImplementation(stepText: "text", function: function)
	}
}
