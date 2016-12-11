//
//  Reflection.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-02.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

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
		let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass?>(allClasses)
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
