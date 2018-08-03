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
//  ScenarioContext.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-25.
//
// ------------------------------------------------------------------------


public protocol ScenarioContext {
	subscript(_ key: String) -> Any? { get set }
	func get<T>(_ key: String) -> T
	var tags: [String] { get set }
	var featureTags: [String] { get set }
}

public class ScenarioContextImplementation : ScenarioContext {
	
	private static var _currentScenarioContext: ScenarioContext! = nil

	public init() {}
	
	public class func reset() {
		_currentScenarioContext = ScenarioContextImplementation()
	}

	public func reset() {
		objects = Dictionary<String, Any>()
	}

	public var tags = [String]()
	public var featureTags = [String]()

	public static var current: ScenarioContext {
		get {
			if _currentScenarioContext == nil {
				_currentScenarioContext = ScenarioContextImplementation()
			}
			return _currentScenarioContext
		}
	}
	
	private var objects = Dictionary<String, Any>()

	public subscript(_ key: String) -> Any? {
		get {
			return objects[key]
		}
		set(newValue) {
			objects[key] = newValue
		}
	}
	
	public func get<T>(_ key: String) -> T {
		return self[key] as! T
	}
}
