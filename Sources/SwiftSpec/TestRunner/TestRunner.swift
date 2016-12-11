//
//  TestRunner.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-06.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import Foundation

public class TestRunner {
	private let registry: BindingsRegistry
	
	public convenience init() {
		self.init(registry: BindingsRegistryImplementation(bindingsRepository: BindingsRepositoryImplementation()))
	}
	
	internal init(registry: BindingsRegistry) {
		self.registry = registry
	}
	
	public func executeStep(_ type: StepType, _ text: String, _ table: Table? = nil) throws {
		let stepBinding = try registry.bindingForStep(stepType: type, stepText: text)
		let matchedParameters = stepBinding.matchParameters(text: text)
		try stepBinding.execute(BindingsParameters(table: table, matchedParameters: matchedParameters))
	}
}
