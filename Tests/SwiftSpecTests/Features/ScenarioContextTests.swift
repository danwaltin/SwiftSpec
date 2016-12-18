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

class InEveryScenarioANewScenarioContextIsAvailableTests : XCTestCase {
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

func testDataAddedToTheScenarioContextIsAvailableInSubsequentStepsTests() {
do {
try testRunner.executeStep(.Given, "that the value 'foo' is added to the current scenario context using the key 'bar'")
try testRunner.executeStep(.Then, "the current scenario context returns the value 'foo' for the key 'bar'")
} catch {
XCTFail("\(error)")
}
}
func testTheScenarioContextIsClearedForEachScenarioTests() {
do {
try testRunner.executeStep(.Given, "a new scenario")
try testRunner.executeStep(.Then, "the current scenario context returns nil for the key 'bar'")
} catch {
XCTFail("\(error)")
}
}
}