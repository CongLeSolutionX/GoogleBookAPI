//
//  GoogleBookTests.swift
//  GoogleBookTests
//
//  Created by Consultant on 2/7/20.
//  Copyright © 2020 Enhance IT. All rights reserved.
//

import XCTest
@testable import GoogleBook

class GoogleBookTests: XCTestCase {
    var sut: URLSession! // SUT is System Under Test
    
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sut = nil // replace the content of object to nil
        super.tearDown() // release the object
    }
    
    // Asynchronous test: success fast, failure slow
    // This test checks that sending a valid query to Google Book server returns a 200 status code
    // Mechanism: This test wait for the request to succeed
    // To experiment the failure of this test, we just change the domain name of the URL path or change the timeout limit
    func testValidCallToGoogleBookGetsHTTPStatusCode200() {
        // GIVEN
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=Harry+Potter")
        // 1. An XCTestExpectation object, stored in promise.
        let promise = expectation(description: "Status code: 200")
        
        // WHEN
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            // THEN
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // If the condition handler of asynchronous method is success, flag that the expextation is met
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // keep the test running until all expectations are fullfilled, or the timeout interval ends, whichever happen first
        wait(for: [promise], timeout: 5)
    }
    // Asynchronous test: faster fail
    // Mechanism: This test waits only until the asynchronous method's completion handler is invoked.
    // This happens as soon as the app receives a response - either OK or error - from the server, which fullfills the expectation
    // To experiment the failure of this test, we just change the domain name of the URL path or change the timeout limit
    func testCallToGoogleBookCompletes() {
        // GIVEN
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=Harry+Potter")
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        //WHEN
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        
        wait(for: [promise], timeout: 1)
        //THEN
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    // Performance test
    func test_StartDownload_Performance() {
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=Harry+Potter")
        measure {
            self.sut?.downloadTask(with: url!)
        }
    }
}
