//
//  BasicFeatureBindings.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-23.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import SwiftSpec
import XCTest

class MathBindings: Bindings {
	
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
	}
}
