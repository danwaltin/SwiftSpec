//
//  MockFeatureParser.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

@testable import SwiftSpec

class MockFeatureParser : FeatureParser {
	var parsedLines: [String] = []
	var featureToReturn: Feature!

	func parse(lines: [String]) -> Feature {
		parsedLines = lines
		return featureToReturn
	}

}
