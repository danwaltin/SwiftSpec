//
//  MockFileSystem.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

@testable import SwiftSpec

class MockFileSystem : FileSystem {
	var filesToReturn: [String] = []
	var fileContentToReturn: [String] = []
	var writtenFiles: [String] = []
	var lastWrittenContent = ""
	
	func subpathsOfDirectory(atPath path: String) throws -> [String] {
		return filesToReturn
	}
	
	func readAllLines(atPath path: String) throws -> [String] {
		return fileContentToReturn
	}

	func writeFile(path: String, content: String) throws {
		writtenFiles.append(path)
		lastWrittenContent = content
	}

}
