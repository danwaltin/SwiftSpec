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
//  FeatureExpandedScenarios.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-08-07.
//
// ------------------------------------------------------------------------

import GherkinSwift

extension Feature {
	func expandedScenarios() -> [Scenario] {
		// first, are there any outlines
		let outlines = scenarios.filter{ $0.isScenarioOutline}
		if outlines.count == 0 {
			return scenarios
		}
		
		var expanded = [Scenario]()
		
		for outline in outlines {
			if outline.examples.count == 0 {
				expanded.append(Scenario(name: outline.name, description: nil, tags: [], location: Location.zero(), steps: [], examples: [], localizedKeyword: ""))
			} else {
				var rows = [TableRow]()
				for examples in outline.examples {
					if let table = examples.table {
						rows.append(contentsOf: table.rows)
					}
				}
				
				if rows.count == 0 {
					expanded.append(Scenario(name: outline.name, description: nil, tags: [], location: Location.zero(), steps: [], examples: [], localizedKeyword: ""))
				}
				for examples in outline.examples {
					if let table = examples.table {
						if table.rows.count > 0  {
							
						}
					}
				}
			}
		}
		return expanded
	}
}
