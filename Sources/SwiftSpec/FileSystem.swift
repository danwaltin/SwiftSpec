//
//  FileSystem.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

protocol FileSystem {
	func subpathsOfDirectory(atPath path: String) throws -> [String]
	func readAllLines(atPath path: String) throws -> [String]
	func writeFile(path: String, content: String) throws
}
