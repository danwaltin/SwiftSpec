//
// AUTOGENERATED FILE
// This code was generated by SwiftSpec
//
// Changes to this file may cause
// incorrect behaviour and will be lost
// if the file is regenerated.
//

import XCTest
import SwiftSpec

class BasicFeatureTests : XCTestCase {
var testRunner:TestRunner!
var scenarioContext:ScenarioContext!

override func setUp() {
super.setUp()
scenarioContext = ScenarioContextImplementation()
scenarioContext.featureTags = []
testRunner = TestRunner(scenarioContext: scenarioContext)
}

override func tearDown() {
testRunner = nil
scenarioContext = nil
super.tearDown()
}

func testBasicScenarioTests() {
do {
try testRunner.executeStep(.given, "there is something")
try testRunner.executeStep(.when, "I do something")
try testRunner.executeStep(.then, "something should happen")
} catch {
XCTFail("\(error)")
}
}
func IGNORE_testAScenarioWhichIsActuallySeveralExamplesTests() {
scenarioContext.tags = ["ignore"]
do {
try testRunner.executeStep(.when, "adding '<arg1>' and '<arg2>'")
try testRunner.executeStep(.then, "the result should be '<result>'")
} catch {
XCTFail("\(error)")
}
}
}