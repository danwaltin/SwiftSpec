//
// AUTOGENERATED FILE
// This code was generated by SwiftSpec
// 2016-12-18 08:57:48+0100
//
// Changes to this file may cause
// incorrect behaviour and will be lost
// if the file is regenerated.
//

import XCTest
import SwiftSpec

class IGNORE_FeaturesWithIgnoreTagAreNotExecutedTests : Ignore {
var testRunner:TestRunner!

override func setUp() {
super.setUp()
testRunner = TestRunner()
ScenarioContext.reset()
ScenarioContext.current.featureTags = ["ignore"]
}

override func tearDown() {
testRunner = nil
super.tearDown()
}

func testThisScenarioWouldFailIfExecutedTests() {
do {
try testRunner.executeStep(.When, "executing a step that fails")
} catch {
XCTFail("\(error)")
}
}
func testThisScenarioWouldAlsoFailIfExecutedTests() {
do {
try testRunner.executeStep(.When, "executing a step that fails")
} catch {
XCTFail("\(error)")
}
}
}