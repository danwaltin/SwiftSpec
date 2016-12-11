//
//  GherkinFeatureParser.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

class GherkinFeatureParser : FeatureParser {
	
	let featureScanner: FeatureScanner
	
	init(featureScanner: FeatureScanner) {
		self.featureScanner = featureScanner
	}
	
	func parse(lines: [String]) -> Feature {
		featureScanner.clear()
		for line in lines {
			featureScanner.scan(line: line)
		}
		return featureScanner.getFeature()
	}
}
