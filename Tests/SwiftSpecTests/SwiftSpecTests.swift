import XCTest
@testable import SwiftSpec

class SwiftSpecTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(SwiftSpec().text, "Hello, World!")
    }


    static var allTests : [(String, (SwiftSpecTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
