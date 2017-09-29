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
//  Reflection.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-02.
//
// ------------------------------------------------------------------------

import Foundation

public class Reflection<T> {
	public init() {
		
	}
	
	public func allSubclasses() -> [T.Type] {
		let matches = allSubclassesAsAnyObject()
		
		return castToReflectedType(matches)
	}
	
	private func castToReflectedType(_ any: [AnyObject]) -> [T.Type] {
		var array = [T.Type]()
		for c in any {
			let t: T.Type = c as! T.Type
			array.append(t)
		}
		
		return array
	}
	
	private func allSubclassesAsAnyObject() -> [AnyObject] {
		var matches:[AnyObject] = []
		let numberOfRegisteredClasses = objc_getClassList(nil, 0)
		let allClasses = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(numberOfRegisteredClasses))
		let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(allClasses)
		let actualClassCount = objc_getClassList(autoreleasingAllClasses, numberOfRegisteredClasses)
		
		for i in 0..<actualClassCount {
			if let currentClass = allClasses[Int(i)] {
				let superclass: AnyClass? = class_getSuperclass(currentClass)
				
				if superclass is T.Type {
					matches.append(currentClass)
				}
			}
		}
		
		allClasses.deallocate(capacity: Int(numberOfRegisteredClasses))
		
		return matches
	}
}
