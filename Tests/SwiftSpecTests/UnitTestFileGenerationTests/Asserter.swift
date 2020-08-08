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
//  Asserter.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-08-08.
//
// ------------------------------------------------------------------------

import XCTest
@testable import SwiftSpec
import GherkinSwift

struct Asserter {
	let actualPickleResult: PickleResult
	
	func gherkinDocument(_ file: StaticString, _ line: UInt, assert: (GherkinDocument) -> Void ) {
		switch actualPickleResult {
		case .success(let document):
			assert(document)
			
		case .error(let error):
			let messages = error.map{$0.message}
			XCTFail("No gherkin document found. Parse error(-s) occurred with message '\(String(describing: messages))'", file: file, line: line)
		}
	}
	
	func feature(_ file: StaticString, _ line: UInt, assert: (Feature) -> Void ) {
		gherkinDocument(file, line) {
			guard let feature = $0.feature else {
				XCTFail("No feature found", file: file, line: line)
				return
			}
			
			assert(feature)
		}
	}
	
	func firstScenario(_ file: StaticString, _ line: UInt, assert: (Scenario) -> Void ) {
		feature(file, line) {
			guard let scenario = $0.scenarios.first else {
				XCTFail("No scenario found", file: file, line: line)
				return
			}
			
			assert(scenario)
		}
	}
}
