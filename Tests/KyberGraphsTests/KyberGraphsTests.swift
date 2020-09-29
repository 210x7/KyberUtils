import XCTest
@testable import KyberGraphs

final class KyberGraphsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(KyberGraphs().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
