//
//  TestFileGenerationBase.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-26.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import XCTest
@testable import SwiftSpec

class TestFileGenerationBase : XCTestCase {

	// MARK:
	// MARK: Factory methods
	
	func tags(_ hasIgnoreTag: Bool) -> [String] {
		if hasIgnoreTag {
			return [ignoreTag]
		}
		return []
	}
}
