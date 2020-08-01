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

class FeaturesAndScenariosCanHaveAssociatedTagsTests : XCTestCase {
var testRunner:TestRunner!
var scenarioContext:ScenarioContext!

override func setUp() {
super.setUp()
scenarioContext = ScenarioContextImplementation()
scenarioContext.featureTags = ["featureTag"]
testRunner = TestRunner(scenarioContext: scenarioContext)
}

override func tearDown() {
testRunner = nil
scenarioContext = nil
super.tearDown()
}

func testAFeatureCanHaveTagsTests() {
do {
try testRunner.executeStep(.then, "this feature has the tag 'featureTag'")
} catch {
XCTFail("\(error)")
}
}
func testAScenarioCanHaveTagsTests() {
scenarioContext.tags = ["one", "two", "three"]
do {
try testRunner.executeStep(.then, "this scenario has the tags 'one', 'two' and 'three'")
} catch {
XCTFail("\(error)")
}
}
}