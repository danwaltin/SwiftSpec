// ------------------------------------------------------------------------
// Copyright 2018 Dan Waltin
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
//  ReflectionTests.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2018-07-21.
//
// ------------------------------------------------------------------------

import Foundation
import XCTest
@testable import SwiftSpec

class ReflectionTests : XCTestCase {
	func test_classWithNoSubclasses() {
		let subclasses = Reflection<ChildLess>().allSubclasses()
		
		XCTAssertEqual(subclasses.count, 0)
	}

	func test_classWithOneSubclass() {
		let subclasses = Reflection<ParentWithOneSubclass>().allSubclasses()
		
		XCTAssertEqual(subclasses.count, 1)
		
		XCTAssertTrue(subclasses[0] is Child.Type)
	}

	func test_classWithTwoSubclasses() {
		let subclasses = Reflection<ParentWithTwoSubclasses>().allSubclasses()
		
		XCTAssertEqual(subclasses.count, 2)

		var foundChild1 = false
		var foundChild2 = false
		
		for subclass in subclasses {
			if subclass is Child1.Type {
				foundChild1 = true
			}

			if subclass is Child2.Type {
				foundChild2 = true
			}
		}
		XCTAssertTrue(foundChild1)
		XCTAssertTrue(foundChild2)
	}
}

class ChildLess {
	
}

class ParentWithOneSubclass {
	
}

class ParentWithTwoSubclasses {
	
}

class Child : ParentWithOneSubclass {
	
}

class Child1 : ParentWithTwoSubclasses {
	
}

class Child2 : ParentWithTwoSubclasses {
	
}
