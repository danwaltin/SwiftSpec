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
//  SetAndGetScenarioContextValuesTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-25.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec

class SetAndGetScenarioContextValuesTests : XCTestCase {
	// MARK: - String values
	func test_setAndRetrieveValues() {
		var context = scenarioContext()

		context["one"] = "alpha"
		context["two"] = SomeStruct(4711)
		context["three"] = 42
		
		XCTAssertEqual(context["one"] as! String, "alpha")
		XCTAssertEqual(context["two"] as! SomeStruct, SomeStruct(4711))
		XCTAssertEqual(context["three"] as! Int, 42)
	}

	func test_setAndRetrieveValuesUsingConvenienceClass() {
		var context = scenarioContext()

		context["one"] = "alpha"
		context["two"] = SomeStruct(4711)
		context["three"] = 42
		
		let asString: String = context.get("one")
		let asStruct: SomeStruct = context.get("two")
		let asInt: Int = context.get("three")
		
		XCTAssertEqual(asString, "alpha")
		XCTAssertEqual(asStruct, SomeStruct(4711))
		XCTAssertEqual(asInt, 42)
	}

	func test_setANewStringValueForTheSameKeyWillReplaceTheOldValue() {
		var context = scenarioContext()

		context["key"] = "old value"
		context["key"] = "new value"
		
		XCTAssertEqual(context["key"] as! String, "new value")
	}

	// MARK: - Access non existing key
	func test_accessingANonExistingKeyReturnsNil() {
		let context = scenarioContext()

		XCTAssertNil(context["key not set"])
	}

	// MARK: - Helpers
	private func scenarioContext() -> ScenarioContext {
		return ScenarioContextImplementation.current
	}
}

struct SomeStruct : Equatable {
	let field: Int
	
	init(_ field: Int) {
		self.field = field
	}
}

