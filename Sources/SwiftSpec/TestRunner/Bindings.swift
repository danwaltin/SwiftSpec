//
//  Binding.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-23.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//
import Foundation

open class Bindings {
	private var bindings = [StepBinding]()
	
	required public init() {}
	
	open func defineBindings() {}
	
	func getAllDefinedBindings() -> [StepBinding] {
		return bindings
	}
	
	open func addBinding(stepText: String, function: @escaping (BindingsParameters) -> ()) {
		bindings.append(StepBindingImplementation(stepText: stepText, function: function))
	}
}
