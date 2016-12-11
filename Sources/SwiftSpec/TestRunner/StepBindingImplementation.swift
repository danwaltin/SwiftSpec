//
//  StepBindingImplementation.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-23.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//
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
				ranges.append(matches.rangeAt(i))
			}
			
			return ranges
		}
		
		return []
		
	}
	
	private func matches(_ text: String) -> NSTextCheckingResult? {
		let range = NSMakeRange(0, text.characters.count)
		let regex = try! NSRegularExpression(pattern: stepText, options: .caseInsensitive)
		
		return regex.firstMatch(in: text, options: [], range: range)
	}
}
