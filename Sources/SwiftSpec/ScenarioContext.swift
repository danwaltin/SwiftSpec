//
//  ScenarioContext.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-25.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//


public class ScenarioContext {
	private static var _currentScenarioContext: ScenarioContext! = nil
	
	public class func reset() {
		_currentScenarioContext = ScenarioContext()
	}

	public var tags = [String]()
	public var featureTags = [String]()

	public static var current: ScenarioContext {
		get {
			if _currentScenarioContext == nil {
				_currentScenarioContext = ScenarioContext()
			}
			return _currentScenarioContext
		}
	}
	
	private var objects = Dictionary<String, Any>()

	public subscript(key: String) -> Any? {
		get {
			return objects[key]
		}
		set(newValue) {
			objects[key] = newValue
		}
	}
}

public class CurrentScenario<T> {
	public init() {
		
	}
	
	public subscript(key: String) -> T? {
		get {
			return ScenarioContext.current[key] as? T
		}
		set(newValue) {
			ScenarioContext.current[key] = newValue
		}
	}	
}
