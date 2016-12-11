//
//  MockBindingsRepository.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-21.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

@testable import SwiftSpec

class MockBindingsRepository : BindingsRepository {
	var stepBindings: [StepBinding] = []
	
	func allBindings() -> [StepBinding] {
		return stepBindings
	}
}
