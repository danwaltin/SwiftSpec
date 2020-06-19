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
//  BindingsParameters.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-08-01.
//
// ------------------------------------------------------------------------

import GherkinSwift

public struct BindingsParameters : Equatable {
	public let table: Table?
	public let matchedParameters: [String]
	
	init(table: Table? = nil, matchedParameters: [String] = []) {
		self.table = table
		self.matchedParameters = matchedParameters
	}
}

public func ==(lhs: BindingsParameters, rhs: BindingsParameters) -> Bool {
	return lhs.table == rhs.table && lhs.matchedParameters == rhs.matchedParameters
}
