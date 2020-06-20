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
//  StringExtensions.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2017-06-24.
//
// ------------------------------------------------------------------------

import Foundation

internal let newLine = "\n"
internal let tripleWhitespace = "   "
internal let doubleWhitespace = "  "
internal let singleWhitespace = " "

public extension String {
	
	func trim() -> String {
		return trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
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
		if count < whitespace.count {
			return self
		}
		
		if !contains(whitespace) {
			return self
		}
		
		return replacingOccurrences(of: whitespace, with: singleWhitespace)
	}
	
	func camelCaseify() -> String {
		let words = components(separatedBy: NSCharacterSet.whitespaces)
		
		var output = ""
		for word in words {
			output += word.capitalized
		}
		
		return output
	}
	
	func allLines() -> [String] {
		if self == "" {
			return []
		}
		
		return components(separatedBy: newLine)
	}
	
	func deleteText(_ text: String) -> String {
		return replacingOccurrences(of: text, with: "")
	}
}

public extension String {
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
