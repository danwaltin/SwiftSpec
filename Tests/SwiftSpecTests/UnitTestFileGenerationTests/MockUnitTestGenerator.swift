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
//  MockUnitTestGenerator.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//
// ------------------------------------------------------------------------
import Foundation
@testable import SwiftSpec
import  GherkinSwift

class MockUnitTestGenerator : UnitTestGenerator {
	var generatedUnitTest = ""
	var lastPickledResult: PickleResult!
	var lastPickledFeaturePath = ""
	
	func generateUnitTest(result: PickleResult, fromFeatureFilePath: String) -> String {
		lastPickledResult = result
		lastPickledFeaturePath = fromFeatureFilePath
		return generatedUnitTest
	}
}
