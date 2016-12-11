//
//  ScenarioScanner.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-08.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

class ScenarioScanner {
	var title = ""
	
	var hasScannedTitle = false
	var isScanningStep = false
	var currentStepScanner: StepScanner!
	var stepScanners = [StepScanner]()
	
	let scenarioTags: [String]
	
	init(scenarioTags: [String]) {
		self.scenarioTags = scenarioTags
	}
	
	func scan(line: String) {
		
		if line.isScenario() {
			title = line.removeKeyword(keywordScenario)
		
		} else if line.isStep() {
			isScanningStep = true
			currentStepScanner = StepScanner()
			stepScanners += [currentStepScanner]
			
			currentStepScanner.scan(line: line)
		} else if isScanningStep {
			currentStepScanner.scan(line: line)
		}
	}
	
	func getScenarios() -> [Scenario] {
		return [Scenario(title: title, tags: scenarioTags, steps: steps())]
	}

	func steps() -> [Step] {
		return stepScanners.map{$0.getStep()}
	}
}
