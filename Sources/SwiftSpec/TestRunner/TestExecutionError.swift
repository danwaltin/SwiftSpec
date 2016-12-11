//
//  TestExecutionError.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-21.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

public enum StepExecutionError : Error {
	case NoStepBindingFoundForStep(stepText: String)
	case MoreThanOneStepBindingFoundForStep(stepText: String)
}

