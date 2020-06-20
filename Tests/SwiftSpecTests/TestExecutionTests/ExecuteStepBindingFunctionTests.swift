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
//  ExecuteStepBindingFunctionTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-23.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
@testable import GherkinSwift

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

	// MARK: - Factory methods
	private func step(_ function: @escaping (BindingsParameters) -> ()) -> StepBindingImplementation {
		return StepBindingImplementation(stepText: "text", function: function)
	}
}
