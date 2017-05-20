// ------------------------------------------------------------------------
// Copyright 2017 Dan Waltin
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ------------------------------------------------------------------------
//
//  GherkinFeatureParser.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//
// ------------------------------------------------------------------------

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
