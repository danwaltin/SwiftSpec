//
//  ScenarioContextBindings.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-25.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import SwiftSpec
import XCTest

class ScenarioContextBindings: Bindings {
	
	override func defineBindings() {
		addBinding(stepText: "that the value 'foo' is added to the current scenario context using the key 'bar'") {_ in 
			ScenarioContext.current["bar"] = "foo"
		}
		
		addBinding(stepText: "a new scenario") {_ in 
			//no-op
		}
		
		addBinding(stepText: "the current scenario context returns the value 'foo' for the key 'bar'") {_ in
			let actual: String = ScenarioContext.current.get("bar")
			XCTAssertEqual(actual, "foo")
		}

		addBinding(stepText: "the current scenario context returns nil for the key 'bar'") {_ in 
			XCTAssertNil(ScenarioContext.current["bar"])
		}
	}
}
