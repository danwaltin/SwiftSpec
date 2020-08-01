// ------------------------------------------------------------------------
// Copyright 2020 Dan Waltin
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
//  MockUnitTestBuilder.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-08-01.
//
// ------------------------------------------------------------------------

@testable import SwiftSpec
import GherkinSwift

class MockUnitTestBuilder : UnitTestBuilder {
	var builtHeader = ""
	var builtFeatureClass = ""
	var builtSetupAndTearDown = ""
	var builtScenarios = [String]()
	var builtFooter = ""
	
	func header() -> String {
		return builtHeader
	}
	
	func featureClass(feature: Feature) -> String {
		return builtFeatureClass
	}
	
	func setupAndTearDown(feature: Feature) -> String {
		return builtSetupAndTearDown
	}
	
	private var scenarioIndex = 0
	
	func scenario(scenario: Scenario) -> String {
		let scenario = builtScenarios[scenarioIndex]
		scenarioIndex += 1
		return scenario
	}
	
	func footer() -> String {
		return builtFooter
	}
}
