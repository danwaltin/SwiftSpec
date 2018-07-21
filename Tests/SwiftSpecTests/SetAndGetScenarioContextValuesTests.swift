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
		ScenarioContext.current["one"] = "alpha"
		ScenarioContext.current["two"] = SomeStruct(4711)
		ScenarioContext.current["three"] = 42
		
		XCTAssertEqual(ScenarioContext.current["one"] as! String, "alpha")
		XCTAssertEqual(ScenarioContext.current["two"] as! SomeStruct, SomeStruct(4711))
		XCTAssertEqual(ScenarioContext.current["three"] as! Int, 42)
	}

	func test_setAndRetrieveValuesUsingConvenienceClass() {
		ScenarioContext.current["one"] = "alpha"
		ScenarioContext.current["two"] = SomeStruct(4711)
		ScenarioContext.current["three"] = 42
		
		XCTAssertEqual(CurrentScenario<String>()["one"], "alpha")
		XCTAssertEqual(CurrentScenario<SomeStruct>()["two"], SomeStruct(4711))
		XCTAssertEqual(CurrentScenario<Int>()["three"], 42)
	}

	func test_setANewStringValueForTheSameKeyWillReplaceTheOldValue() {
		ScenarioContext.current["key"] = "old value"
		ScenarioContext.current["key"] = "new value"
		
		XCTAssertEqual(ScenarioContext.current["key"] as! String, "new value")
	}

	// MARK: - Access non existing key
	func test_accessingANonExistingKeyReturnsNil() {
		XCTAssertNil(ScenarioContext.current["key not set"])
	}

	// MARK: - Reset context
	func test_whenResettingContext_oldValuesAreCleared() {
		ScenarioContext.current["string"] = "alpha"
		ScenarioContext.current["struct"] = SomeStruct(4711)

		ScenarioContext.reset()

		XCTAssertNil(ScenarioContext.current["string"])
		XCTAssertNil(ScenarioContext.current["struct"])
	}
}

struct SomeStruct : Equatable {
	let field: Int
	
	init(_ field: Int) {
		self.field = field
	}
}

func ==(lhs: SomeStruct, rhs: SomeStruct) -> Bool {
	return lhs.field == rhs.field
}
