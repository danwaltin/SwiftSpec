// ------------------------------------------------------------------------
// Copyright 2020 Dan Waltin
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
//  StepExtensions.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-07-24.
//
// ------------------------------------------------------------------------

import GherkinSwift

extension Step {
	static func given(_ text: String, _ table: Table? = nil) -> Step {
		return step(.given, text, table)
	}

	static func when(_ text: String, _ table: Table? = nil) -> Step {
		return step(.when, text, table)
	}

	static func then(_ text: String, _ table: Table? = nil) -> Step {
		return step(.then, text, table)
	}

	private static func step(_ stepType: StepType, _ text: String, _ table: Table? = nil) -> Step {
		return Step(stepType, text, location: Location.zero(), tableParameter: table, docStringParameter: nil, localizedKeyword: "Localized keyword")
	}
}
