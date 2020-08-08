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
		return scenarios.flatMap { expand($0) }
	}
	
	private func expand(_ scenario: Scenario) -> [Scenario] {
		let shouldExpand = scenario.isScenarioOutline && hasExampleRows(scenario)
		if !shouldExpand {
			return [scenario]
		}

		var expanded = [Scenario]()

		for examples in scenario.examples {
			let names = expandedNames(from: examples, scenarioName: scenario.name)
			if names.count > 0 {
				expanded.append(contentsOf: names.map { cloneScenario(scenario, withName: $0)})
			}
		}
		
		return expanded
	}
	
	private func expandedNames(from examples: ScenarioOutlineExamples, scenarioName: String) -> [String] {
		let examplesName = examples.name.count == 0 ? "" : "_" + examples.name
		var names = [String]()
		if let table = examples.table {
			for (index, _) in table.rows.enumerated()  {
				names.append("\(scenarioName)\(examplesName)_\(index)")
			}
		}

		return names
	}
	
	private func hasExampleRows(_ scenario: Scenario) -> Bool {
		var rows = [TableRow]()
		for examples in scenario.examples {
			if let table = examples.table {
				rows.append(contentsOf: table.rows)
			}
		}
		
		return rows.count > 0
	}
	
	private func cloneScenario(_ scenario: Scenario, withName name: String) -> Scenario {
		return Scenario(name: name,
						description: scenario.description,
						tags: scenario.tags,
						location: scenario.location,
						steps: [],
						examples: [],
						localizedKeyword: "")
	}
}
