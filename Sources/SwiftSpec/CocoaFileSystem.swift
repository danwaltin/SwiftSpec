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
//  CocoaFileSystem.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-06-26.
//
// ------------------------------------------------------------------------

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
