//
//  APIClientTests.swift
//  ToDoTests
//
//  Created by Akshay Jain on 13/05/2020.
//  Copyright © 2020 Akshay Jain. All rights reserved.
//

import XCTest
@testable import ToDo

class APIClientTests: XCTestCase {
    
    var sut: APIClient!
    var mockURLSession: MockURLSession!
    
    override func setUpWithError() throws {
        
        sut = APIClient()
        
        mockURLSession = MockURLSession()
        sut.session = mockURLSession
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLogin_MakesRequestWithUsernameAndPassword() {
        
        let sut = APIClient() //1
        let mockURLSession = MockURLSession() //2
        sut.session = mockURLSession //inject the dependency
        
        typealias completion = (Error?) -> Void //We didnt use this
        
        sut.loginUserWithName(username: "dasdöm", password: "%&34") { (error) in
            
        }
        XCTAssertNotNil(mockURLSession.completionHandler)
        
        guard let url = mockURLSession.url else { XCTFail(); return }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.host, "awesometodos.com") //Test the URL
        XCTAssertEqual(urlComponents?.path, "/login") //Test the path
        guard let expectedUsername = "dasdöm".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            fatalError()
        }
        guard let expectedPassword = "%&34".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            fatalError()
        }
        
        XCTAssertEqual(urlComponents?.percentEncodedQuery,
                       "username=\(expectedUsername)&password=\(expectedPassword)")
    }
    
    func testLogin_CallsResumeOfDataTask() {
        
        sut.loginUserWithName(username: "dasdom", password: "1234") { (error) in
            
        }
        
        XCTAssertTrue(mockURLSession.dataTask.resumeGotCalled)
    }
    
    func testLogin_SetsToken() {
        
        let mockKeychainManager = MockKeychainMananger()
        sut.keychainManager = mockKeychainManager
        
        sut.loginUserWithName(username: "dasdom", password: "1234") { (error) in
            
        }
        
        let responseDict = ["token" : "1234567890"]
        let responseData = try! JSONSerialization.data(withJSONObject: responseDict, options: [])
        mockURLSession.completionHandler?(responseData, nil, nil)
        
        let token = mockKeychainManager.passwordForAccount(account: "token")
        XCTAssertEqual(token, responseDict["token"])
    }
    
    func testLogin_ThrowsErrorWhenJSONIsInvalid() {
        
        var requestError : Error?
        sut.loginUserWithName(username: "dasdom", password: "1234") { (error) in
            requestError = error
        }
        
        let responseData = Data()
        mockURLSession.completionHandler?(responseData, nil, nil)
        
        XCTAssertNotNil(requestError)
    }
    
    func testLogin_ThrowsErrorWhenDataIsNil() {
        
        var requestError : Error?

        sut.loginUserWithName(username: "dasdom", password: "1234") { (error) in
            requestError = error
        }

        mockURLSession.completionHandler?(nil, nil, nil)
        
        XCTAssertNotNil(requestError)
    }
    
    func testLogin_ThrowsErrorWhenResponseHasError() {
        
        var requestError : Error?
        sut.loginUserWithName(username: "dasdom", password: "1234") { (error) in
            requestError = error
        }
        
        let responseDict = ["token" : "1234567890"]
        let responseData = try! JSONSerialization.data(withJSONObject: responseDict,
            options: [])
        let error = NSError(domain: "SomeError", code:
            1234, userInfo: nil)
        mockURLSession.completionHandler?(responseData, nil, error)
        
        XCTAssertNotNil(requestError)
    }
    
}

extension APIClientTests {
    
    class MockURLSession : ToDoURLSession {
        
        typealias Handler = (Data?, URLResponse?, Error?) -> Void
        
        var completionHandler: Handler?
        var url: URL?
        var dataTask = MockURLSessionDataTask()
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            self.completionHandler = completionHandler
            return dataTask
        }
    }
    
    class MockURLSessionDataTask : URLSessionDataTask {
        var resumeGotCalled = false
        
        override func resume() {
            resumeGotCalled = true
        }
    }
    
    class MockKeychainMananger : KeychainAccessible {
        var passwordDict = [String:String]()
        
        func setPassword(password: String,
                         account: String) {
            passwordDict[account] = password
        }
        
        func deletePasswortForAccount(account: String) {
            passwordDict.removeValue(forKey: account)
        }
        
        func passwordForAccount(account: String) -> String? {
            return passwordDict[account]
        }
    }
    
}
