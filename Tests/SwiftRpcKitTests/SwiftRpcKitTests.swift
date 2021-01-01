import XCTest
@testable import SwiftRpcKit

final class SwiftRpcKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftRpcKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
