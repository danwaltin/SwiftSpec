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

class BasicFeatureTests : XCTestCase {
var testRunner:TestRunner!

override func setUp() {
super.setUp()
testRunner = TestRunner()
ScenarioContext.reset()

}

override func tearDown() {
testRunner = nil
super.tearDown()
}

func testBasicScenarioTests() {
do {
try testRunner.executeStep(.Given, "there is something")
try testRunner.executeStep(.When, "I do something")
try testRunner.executeStep(.Then, "something should happen")
} catch {
XCTFail("\(error)")
}
}
func testAScenarioWhichIsActuallySeveralExamples_0Tests() {
do {
try testRunner.executeStep(.When, "adding '1' and '1'")
try testRunner.executeStep(.Then, "the result should be '2'")
} catch {
XCTFail("\(error)")
}
}
func testAScenarioWhichIsActuallySeveralExamples_1Tests() {
do {
try testRunner.executeStep(.When, "adding '10' and '20'")
try testRunner.executeStep(.Then, "the result should be '30'")
} catch {
XCTFail("\(error)")
}
}
func testAScenarioWhichIsActuallySeveralExamples_2Tests() {
do {
try testRunner.executeStep(.When, "adding '42' and '17'")
try testRunner.executeStep(.Then, "the result should be '59'")
} catch {
XCTFail("\(error)")
}
}
}