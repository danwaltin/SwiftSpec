//
//  BasicFeatureBindings.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-23.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import SwiftSpec
import XCTest

class BasicFeatureBindings: Bindings {
	
	override func defineBindings() {
		addBinding(stepText: "there is something") {_ in 
			XCTAssertTrue(true)
		}

		addBinding(stepText: "I do something") {_ in 
			XCTAssertTrue(true)
		}

		addBinding(stepText: "something should happen") {_ in 
			XCTAssertTrue(true)
		}
		
		addBinding(stepText: "adding '(.*)' and '(.*)'") {
			let arg1 = Int($0.matchedParameters[0])!
			let arg2 = Int($0.matchedParameters[1])!
			
			self.scenarioContext["addResult"] = arg1 + arg2
		}
		
		addBinding(stepText: "the result should be '(.*)'") {
			let result = Int($0.matchedParameters[0])!
			let actual: Int = self.scenarioContext.get("addResult")
			
			XCTAssertEqual(actual, result)
		}
	}
}
