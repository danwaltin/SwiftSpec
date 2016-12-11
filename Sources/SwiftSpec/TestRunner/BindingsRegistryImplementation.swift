//
//  BindingsRegistryImplementation.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-09.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

class BindingsRegistryImplementation : BindingsRegistry {
	
	private let bindingsRepository: BindingsRepository
	
	init(bindingsRepository: BindingsRepository) {
		self.bindingsRepository = bindingsRepository
	}
	
	func bindingForStep(stepType: StepType, stepText: String) throws -> StepBinding {
		let bindings = matchedBindings(stepText)

		if bindings.count == 0 {
			throw StepExecutionError.NoStepBindingFoundForStep(stepText: stepText)
		}

		if bindings.count > 1 {
			throw StepExecutionError.MoreThanOneStepBindingFoundForStep(stepText: stepText)
		}

		return bindings.first!
	}
	
	private func matchedBindings(_ stepText: String) -> [StepBinding] {
		let allBindings = bindingsRepository.allBindings()
		return allBindings.filter {$0.matches(text: stepText)}
	}
}
