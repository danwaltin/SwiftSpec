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
//  FeatureScanner.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-30.
//
// ------------------------------------------------------------------------

import Foundation


class FeatureScanner {
	var featureTags = [String]()
	let tagScanner = TagScanner()

	var featureTitle = ""
	var hasScannedFeatureTitle = false

	var isScanningScenarios = false
	var currentScenarioScanner: ScenarioScanner!
	var scenarioScanners: [ScenarioScanner] = []
	
	init() {
		clear()
	}
	
	func clear() {
		featureTitle = ""
		hasScannedFeatureTitle = false
	
		isScanningScenarios = false
		currentScenarioScanner = nil
		scenarioScanners = []
	}
	
	func scan(line: String) {
		
		if line.isTag() {
			tagScanner.scan(line: line)
		
		} else if line.isFeature() {
			featureTitle = line.removeKeyword(keywordFeature)
			hasScannedFeatureTitle = true
			featureTags = tagScanner.getTags()
			tagScanner.clear()
			
		} else if line.isScenarioOutline() {
			currentScenarioScanner = ScenarioOutlineScanner(scenarioTags: tagScanner.getTags())
			tagScanner.clear()
			scenarioScanners += [currentScenarioScanner]
			
			isScanningScenarios = true
			
			currentScenarioScanner.scan(line: line)

		} else if line.isScenario() {
			currentScenarioScanner = ScenarioScanner(scenarioTags: tagScanner.getTags())
			tagScanner.clear()
			scenarioScanners += [currentScenarioScanner]
			
			isScanningScenarios = true
			
			currentScenarioScanner.scan(line: line)

		} else if isScanningScenarios {
			currentScenarioScanner.scan(line: line)
		}
	}
	
	func getFeature() -> Feature {
		return Feature(title: featureTitle, tags: featureTags, scenarios: getScenarios())
	}
	
	private func getScenarios() -> [Scenario] {
		var s = [Scenario]()
		for scanner in scenarioScanners {
			s.append(contentsOf: scanner.getScenarios())
		}
		return s
	}
}
