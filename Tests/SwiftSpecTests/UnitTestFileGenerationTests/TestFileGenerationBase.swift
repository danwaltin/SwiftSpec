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
//  TestFileGenerationBase.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-26.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
import  GherkinSwift

class TestFileGenerationBase : XCTestCase {

	// MARK: - Factory methods
	
	func feature(name: String, tags: [Tag] = []) -> Feature {
		return Feature(name: name, description: nil, background: nil, tags: tags, location: Location.zero(), language: "en", localizedKeyword: "Feature")
	}

	func tags(_ hasIgnoreTag: Bool) -> [Tag] {
		if hasIgnoreTag {
			return [Tag(name: ignoreTag, location: Location.zero())]
		}
		return []
	}
}
