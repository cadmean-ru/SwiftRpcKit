import XCTest
@testable import RpcKit

final class RpcKitTests: XCTestCase {
    
    let client = RpcClient(at: "http://localhost:5000")
    
    func testSum() {
        let expectation = XCTestExpectation(description: "Make call to sum rpc function")
        
        client.function(named: "test.addInt").call(with: Argument(of: 1), Argument(of: 2)) { (res: Int?, err) in
            XCTAssertEqual(res, 3, "Sum was not 3")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testConcat() {
        let expectation = XCTestExpectation(description: "Make call to concat rpc function")
        
        client.function(named: "test.concatString").call(with: Argument(of: "Hello,"), Argument(of: " world!")) { (res: String?, err) in
            XCTAssertEqual(res, "Hello, world!", "Strings were not equal")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testSquare() {
        let num = 0.3
        let expected = 0.09
        
        let expectation = XCTestExpectation(description: "Make call to square rpc function")
        
        client.function(named: "test.squareDouble").call(with: Argument(of: num)) { (res: Double?, err) in
            XCTAssertEqual(res, expected)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testError() {
        let expectation = XCTestExpectation(description: "Make call to error rpc function")
        
        client.function(named: "test.getException").call(with: Argument(of: true)) { (res: String?, err) in
            XCTAssertEqual(err, .serverError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    private struct User : Codable {
        let name: String?
        let email: String?
    }
    
    func testAuth() {
        let email = "email@example.com"
        let password = "password"
        
        let expectation = XCTestExpectation(description: "Authorize by calling the auth rpc function. And then get user info.")
        
        client.function(named: "test.auth2").call(with: Argument(of: email), Argument(of: password)) { (ticket: AuthTicket?, err) in
            XCTAssertNotNil(ticket)
            XCTAssertNotNil(ticket?.accessToken)
            XCTAssertNotNil(ticket?.refreshToken)
            
            print("Auth ticket: \(String(describing: ticket))")
            
            self.client.function(named: "test.getUserAuth").call(with: Argument(of: email)) { (user: User?, err) in
                XCTAssertNotNil(user)
                
                print("User: \(String(describing: user))")
                
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetDate() {
        let expectation = XCTestExpectation(description: "Get current date by calling rpc function getDate")
        
        client.function(named: "test.getDate").call() { (res: Date?, err) in
            XCTAssertNotNil(res)
            
            print("Date: \(String(describing: res))")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }

    static var allTests = [
        ("testSum", testSum),
        ("testConcat", testConcat),
        ("testError", testError),
        ("testSquare", testSquare),
        ("testAuth", testAuth),
        ("testGetDate", testGetDate)
    ]
}
