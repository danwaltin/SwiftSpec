//
//  main.swift
//  SwiftSpec
//
//  Created by Dan Waltin on 2016-12-17.
//
//

import Foundation
import SwiftSpec

let builder = XBuilder()
let writer = builder.buildTestFileWriter()
let path = CommandLine.arguments[1]

writer.generateUnitTestsFromFeatureFiles(baseDirectory: path)
