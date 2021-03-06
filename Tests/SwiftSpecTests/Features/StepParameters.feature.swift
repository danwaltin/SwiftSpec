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

class StepsParametersArePassedToTheBindingMethodsTests : XCTestCase {
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

func testTableParameters() {
do {
let table1 = TableParameter(columns: ["Name", "Balance"])
.addingRow(cells: ["Coffee", "1111"])
.addingRow(cells: ["Computers", "2222"])
try testRunner.executeStep(.given, "the following accounts", table1)
try testRunner.executeStep(.when, "the balance of account 'Computers' is changed to 3333")
let table2 = TableParameter(columns: ["Name", "Balance"])
.addingRow(cells: ["Coffee", "1111"])
.addingRow(cells: ["Computers", "3333"])
try testRunner.executeStep(.then, "should accounts as follows exist", table2)
} catch {
XCTFail("\(error)")
}
}
}