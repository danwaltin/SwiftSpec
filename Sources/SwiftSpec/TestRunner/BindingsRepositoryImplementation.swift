//
//  BindingsRepositoryImplementation.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-21.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import Foundation

class BindingsRepositoryImplementation: BindingsRepository {
	func allBindings() -> [StepBinding] {
		let reflector = Reflection<Bindings>()
		let allBindingsClasses = reflector.allSubclasses()
		
		var bindings = [StepBinding]()
		
		for c in allBindingsClasses {
			let instance = c.init()
			instance.defineBindings()
			bindings.append(contentsOf: instance.getAllDefinedBindings())
		}
		return bindings
	}
}
