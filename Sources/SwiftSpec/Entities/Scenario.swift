//
//  Scenario.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-03.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

struct Scenario : Equatable, Taggable, HasTitle {
	let title: String
	let tags: [String]
	let steps: [Step]
	
	init(title: String, tags: [String] = [], steps: [Step]) {
		self.title = title
		self.tags = tags
		self.steps = steps
	}
}

func == (lhs: Scenario, rhs: Scenario) -> Bool {
	return
		lhs.title == rhs.title &&
		lhs.tags == rhs.tags &&
		lhs.steps == rhs.steps
	
}
