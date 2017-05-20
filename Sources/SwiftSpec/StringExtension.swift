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
//  StringExtension.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//
// ------------------------------------------------------------------------

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
