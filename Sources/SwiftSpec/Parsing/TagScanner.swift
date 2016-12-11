//
//  TagScanner.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-07-28.
//  Copyright © 2016 Dan Waltin. All rights reserved.
//

class TagScanner {

	var tags = [String]()

	func scan(line: String) {
		if line.isTag() {
			tags.append(contentsOf: tagsFromLine(line))
		}
	}
	
	func clear() {
		tags = []
	}
	
	func getTags() -> [String] {
		return tags
	}

	private func tagsFromLine(_ line: String) -> [String] {
		let parts = line.trim().compactWhitespace().trim().components(separatedBy: .whitespaces)
		return parts.map{$0.removeKeyword(tagToken)}
	}
}
