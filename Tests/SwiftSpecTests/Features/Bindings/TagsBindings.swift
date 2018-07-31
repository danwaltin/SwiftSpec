//
//  TagsBindings.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-26.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import SwiftSpec
import XCTest

class TagsBindings: Bindings {
	override func defineBindings() {
		addBinding(stepText: "executing a step that fails") {_ in 
			XCTFail("This should never happen")
		}

		addBinding(stepText: "executing a step that succeedes") {_ in 
			XCTAssertTrue(true)
		}
		
		addBinding(stepText: "this feature has the tag 'featureTag'") {_ in 
			XCTAssertEqual(self.scenarioContext.featureTags, ["featureTag"])
		}
		
		addBinding(stepText: "this scenario have the tags 'one', 'two' and 'three'") {_ in 
			XCTAssertEqual(self.scenarioContext.tags, ["one", "two", "three"])
		}
	}
}
