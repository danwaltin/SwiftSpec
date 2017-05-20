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
//  ScenarioScanner.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-08.
//
// ------------------------------------------------------------------------

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
