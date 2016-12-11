//
//  SetAndGetScenarioContextValuesTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-25.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import XCTest
@testable import SwiftSpec

class SetAndGetScenarioContextValuesTests : XCTestCase {
	// MARK:
	// MARK: String values
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

	// MARK:
	// MARK: Access non existing key
	func test_accessingANonExistingKeyReturnsNil() {
		XCTAssertNil(ScenarioContext.current["key not set"])
	}

	// MARK:
	// MARK: Reset context
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
