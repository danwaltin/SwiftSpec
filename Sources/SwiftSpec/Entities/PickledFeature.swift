//
//  PickledFeature.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2020-06-19.
//

import Foundation

struct GherkinDocument : Equatable, Decodable {
	static func from(feature: Feature) -> GherkinDocument {
		return GherkinDocument(feature: PickledFeature(name: feature.title))
	}

	let feature: PickledFeature
}

struct PickledFeature : Equatable, Decodable {

	let name: String
}
