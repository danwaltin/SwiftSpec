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

public extension String {
		
	func camelCaseify() -> String {
		let words = components(separatedBy: NSCharacterSet.whitespaces)
		
		var output = ""
		for word in words {
			output += word.capitalized
		}
		
		return output
	}
}

public extension String {
	func pathExtension() -> String {
		return asNSString().pathExtension
	}
	
	func stringByDeletingPathExtension() -> String {
		return asNSString().deletingPathExtension
	}

	func lastPathComponent() -> String {
		return asNSString().lastPathComponent
	}

	func asNSString() -> NSString {
		return NSString(string: self)
	}
}
