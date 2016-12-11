//
//  Feature.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

struct Feature : Equatable, Taggable, HasTitle {
	let title: String
	let tags: [String]
	let scenarios: [Scenario]
	
	init(title: String, tags: [String] = [], scenarios: [Scenario] = []) {
		self.title = title
		self.tags = tags
		self.scenarios = scenarios
	}
}

func == (lhs: Feature, rhs: Feature) -> Bool {
	return
		lhs.title == rhs.title &&
		lhs.tags == rhs.tags &&
		lhs.scenarios == rhs.scenarios
}
