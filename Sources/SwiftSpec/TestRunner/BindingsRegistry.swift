//
//  BindingsRegistry.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-09.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

protocol BindingsRegistry {
	
	// for the following step
	//		Given something
	//
	// this method should be called as follows
	//		bindingForStep(stepType: .Given, stepText: "something")
	//
	func bindingForStep(stepType: StepType, stepText: String) throws -> StepBinding
}

