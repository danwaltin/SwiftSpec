//
//  CocoaFileSystem.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

import Foundation

class CocoaFileSystem : FileSystem {
	func subpathsOfDirectory(atPath path: String) throws -> [String] {
		return try fileManager().subpathsOfDirectory(atPath: path)
	}
	
	func readAllLines(atPath path: String) throws -> [String] {
		let content = fileContent(path: path)
		let lines = content.allLines()
		return lines
	}
	
	func writeFile(path: String, content: String) throws {
		try content.write(toFile: path, atomically:true, encoding:String.Encoding.utf8)
	}
	
	func fileContent(path: String) -> String {
		return try! String(contentsOfFile: path, encoding:String.Encoding.utf8)
	}

	private func fileManager() -> FileManager {
		return FileManager.default
	}
}
