//
//  FeatureScanner.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-30.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

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
