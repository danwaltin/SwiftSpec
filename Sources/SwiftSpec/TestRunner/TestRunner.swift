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
//  TestRunner.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-06.
//
// ------------------------------------------------------------------------

import Foundation

public class TestRunner {
	private let registry: BindingsRegistry
	private let scenarioContext: ScenarioContext
	
	public convenience init(scenarioContext: ScenarioContext) {
		self.init(
			registry: BindingsRegistryImplementation(bindingsRepository: BindingsRepositoryImplementation()),
			scenarioContext: scenarioContext)
	}
	
	internal init(registry: BindingsRegistry, scenarioContext: ScenarioContext) {
		self.registry = registry
		self.scenarioContext = scenarioContext
	}
	
	public func executeStep(_ type: StepType, _ text: String, _ table: Table? = nil) throws {
		let stepBinding = try registry.bindingForStep(stepType: type, stepText: text, scenarionContext: scenarioContext)
		let matchedParameters = stepBinding.matchParameters(text: text)
		try stepBinding.execute(BindingsParameters(table: table, matchedParameters: matchedParameters))
	}
}
