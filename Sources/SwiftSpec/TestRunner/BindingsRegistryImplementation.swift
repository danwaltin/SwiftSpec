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
//  BindingsRegistryImplementation.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-09.
//
// ------------------------------------------------------------------------

class BindingsRegistryImplementation : BindingsRegistry {
	
	private let bindingsRepository: BindingsRepository
	
	init(bindingsRepository: BindingsRepository) {
		self.bindingsRepository = bindingsRepository
	}
	
	func bindingForStep(stepType: StepType, stepText: String, scenarionContext: ScenarioContext) throws -> StepBinding {
		let bindings = matchedBindings(stepText, scenarionContext: scenarionContext)

		if bindings.count == 0 {
			throw StepExecutionError.NoStepBindingFoundForStep(stepText: stepText)
		}

		if bindings.count > 1 {
			throw StepExecutionError.MoreThanOneStepBindingFoundForStep(stepText: stepText)
		}

		return bindings.first!
	}
	
	private func matchedBindings(_ stepText: String, scenarionContext: ScenarioContext) -> [StepBinding] {
		let allBindings = bindingsRepository.allBindings(scenarionContext: scenarionContext)
		return allBindings.filter {$0.matches(text: stepText)}
	}
}
