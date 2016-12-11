//
//  BindingsParameters.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-08-01.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

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
