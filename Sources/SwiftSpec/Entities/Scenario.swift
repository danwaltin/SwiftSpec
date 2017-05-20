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
//  Scenario.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-03.
//
// ------------------------------------------------------------------------

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
