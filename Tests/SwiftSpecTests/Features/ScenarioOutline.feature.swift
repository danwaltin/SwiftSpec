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

class ScenarioOutlineTests : XCTestCase {
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

func testTheSumOfTwoNumbersTests() {
do {
try testRunner.executeStep(.when, "adding '<arg1>' and '<arg2>'")
try testRunner.executeStep(.then, "the result should be '<result>'")
} catch {
XCTFail("\(error)")
}
}
func testMathUsingReversePolishNotationTests() {
do {
try testRunner.executeStep(.given, "that operand '<operand1>' has been entered")
try testRunner.executeStep(.and, "that operand '<operand2>' has been entered")
try testRunner.executeStep(.when, "entering operator '<operator>'")
try testRunner.executeStep(.then, "the result should be '<result>'")
} catch {
XCTFail("\(error)")
}
}
func testAddingANumberToItselfTests() {
do {
try testRunner.executeStep(.when, "adding '<arg>' and '<arg>'")
try testRunner.executeStep(.then, "the result should be '<result>'")
} catch {
XCTFail("\(error)")
}
}
}