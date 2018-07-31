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
//  Binding.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-23.
//
// ------------------------------------------------------------------------

import Foundation

open class Bindings {
	private var bindings = [StepBinding]()
	public var scenarioContext: ScenarioContext
	
	required public init(scenarionContext: ScenarioContext) {
		self.scenarioContext = scenarionContext
	}
	
	open func defineBindings() {}
	
	func getAllDefinedBindings() -> [StepBinding] {
		return bindings
	}
	
	open func addBinding(stepText: String, function: @escaping (BindingsParameters) -> ()) {
		bindings.append(StepBindingImplementation(stepText: stepText, function: function))
	}
}
