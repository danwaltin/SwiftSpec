//
//  StepBinding.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-09.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

protocol StepBinding {
	func execute(_ parameters: BindingsParameters) throws
	func matches(text: String) -> Bool
	func matchParameters(text: String) -> [String]
}
