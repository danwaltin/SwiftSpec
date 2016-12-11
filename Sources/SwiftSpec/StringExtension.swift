//
//  StringExtension.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import Foundation

internal let newLine = "\n"
internal let tripleWhitespace = "   "
internal let doubleWhitespace = "  "
internal let singleWhitespace = " "

extension String {
	
	func trim() -> String {
		return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
	}
	
	func appendLine() -> String {
		return self + newLine
	}
	
	func appendLine(_ line: String) -> String {
		if self == "" {
			return self + line
		}
		return self + newLine + line
	}
	
	func compactWhitespace() -> String {
		return _remove(tripleWhitespace)._remove(doubleWhitespace)
	}
	
	private func _remove(_ whitespace: String) -> String {
		if self.characters.count < whitespace.characters.count {
			return self
		}
		
		if !self.contains(whitespace) {
			return self
		}
		
		return self.replacingOccurrences(of: whitespace, with: singleWhitespace)
	}

	func camelCaseify() -> String {
		let words = asNSString().components(separatedBy: NSCharacterSet.whitespaces)
		
		var output = ""
		for word in words {
			output += word.asNSString().capitalized
		}
		
		return output
	}
	
	func allLines() -> [String] {
		if self == "" {
			return []
		}
		
		return self.asNSString().components(separatedBy: newLine)
	}

	func deleteText(_ text: String) -> String {
		return self.asNSString().replacingOccurrences(of: text, with: "")
	}
}

extension String {
	func pathExtension() -> String {
		return asNSString().pathExtension
	}

	func stringByDeletingPathExtension() -> String {
		return asNSString().deletingPathExtension
	}
	
	func asNSString() -> NSString {
		return NSString(string: self)
	}
}
