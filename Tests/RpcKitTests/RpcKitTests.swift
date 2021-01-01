import XCTest
@testable import RpcKit

final class RpcKitTests: XCTestCase {
    
    let client = RpcClient(at: "http://testrpc.cadmean.ru")
    
    func testSum() {
        let expectation = XCTestExpectation(description: "Make call to sum rpc function")
        
        client.function(of: "sum").call(with: Argument(of: 1), Argument(of: 2)) { (res: Int?, err) in
            XCTAssertEqual(res, 3, "Sum was not 3")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testConcat() {
        let expectation = XCTestExpectation(description: "Make call to concat rpc function")
        
        client.function(of: "concat").call(with: Argument(of: "Hello,"), Argument(of: " world!")) { (res: String?, err) in
            XCTAssertEqual(res, "Hello, world!", "Strings were not equal")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testError() {
        let expectation = XCTestExpectation(description: "Make call to error rpc function")
        
        client.function(of: "error").call(with: Argument(of: true)) { (res: String?, err) in
            XCTAssertEqual(err, .custom(42))
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }

    static var allTests = [
        ("testSum", testSum),
        ("testConcat", testConcat),
        ("testError", testError)
    ]
}
