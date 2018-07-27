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
//  StepBindingImplementation.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-23.
//
// ------------------------------------------------------------------------

import Foundation

class StepBindingImplementation: StepBinding {
	
	let stepText: String
	let function: (BindingsParameters) -> ()
	
	init(stepText: String, function: @escaping (BindingsParameters) -> ()) {
		self.stepText = stepText
		self.function = function
	}
	
	func execute(_ parameters: BindingsParameters) throws {
		function(parameters)
	}
	
	func matches(text: String) -> Bool {
		if stepText == "" {
			return stepText == text
		}
		
		return matches(text) != nil
	}
	
	func matchParameters(text: String) -> [String] {
		return getMatch(text)
	}
	
	private func getMatch(_ text: String) -> [String] {
		return matchRanges(text).map{ (text as NSString).substring(with: $0)}
	}

	private func matchRanges(_ text: String) -> [NSRange] {
		if let matches = matches(text) {
			var ranges = [NSRange]()
			for i in 1..<matches.numberOfRanges {
				ranges.append(matches.range(at: i))
			}
			
			return ranges
		}
		
		return []
		
	}
	
	private func matches(_ text: String) -> NSTextCheckingResult? {
		let range = NSMakeRange(0, text.count)
		let regex = try! NSRegularExpression(pattern: stepText, options: .caseInsensitive)
		
		return regex.firstMatch(in: text, options: [], range: range)
	}
}
