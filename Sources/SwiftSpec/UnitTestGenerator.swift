//
//  UnitTestGenerator.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import Foundation

protocol UnitTestGenerator {
	func generateUnitTest(feature: Feature) -> String
}
