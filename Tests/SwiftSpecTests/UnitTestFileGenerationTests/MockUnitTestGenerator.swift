//
//  MockUnitTestGenerator.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//
import Foundation

@testable import SwiftSpec

class MockUnitTestGenerator : UnitTestGenerator {
	var generatedUnitTest = ""
	var lastParsedFeature: Feature!
	
	func generateUnitTest(feature: Feature) -> String {
		lastParsedFeature = feature
		return generatedUnitTest
	}
}
