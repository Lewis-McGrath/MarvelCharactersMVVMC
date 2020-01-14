//
//  CharacterListServiceTests.swift
//  Marvel MVVMC
//
//  Created by Lewis McGrath on 19/11/2019.
//  Copyright © 2019 Lewis McGrath. All rights reserved.
//

import XCTest

@testable import Marvel_MVVMC

class CharacterListServiceTests: XCTestCase {

    var subject: CharacterListService!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        
        mockURLSession = MockURLSession()
        subject = CharacterListService(dataSession: mockURLSession)
    }

    override func tearDown() {
        super.tearDown()
        subject = nil
    }
    
    
     // MARK: Testing CharacterDetail Call

    func test_getCharacterDataResponse_respondsWithError_respondWithNilResponse() {
        mockURLSession.error = TestError.networkError
        
        let expectation = XCTestExpectation()
        subject.getCharacterDataResponse { response in
            XCTAssertNil(response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getCharacterDataResponse_respondsHTTPResponse_respondWithNilResponse() {
        let response = HTTPURLResponse(url: URL(string: "fake")!, statusCode: 180, httpVersion: nil, headerFields: nil)
        mockURLSession.response = response

        let expectation = XCTestExpectation()
        subject.getCharacterDataResponse { response in
            XCTAssertNil(response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getCharacterDataResponse_noError_accpetableStatusCode_dataCorrect_responseReceived() {
        
        let response = HTTPURLResponse(url: URL(string: "fake")!, statusCode: 220, httpVersion: nil, headerFields: nil)
        let testBundle = Bundle(for: CharacterListServiceTests.self)
        let url = testBundle.url(forResource: "mockresponse", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        mockURLSession.response = response
        mockURLSession.data = data
        let expectation = XCTestExpectation()
        subject.getCharacterDataResponse { (response) in
            XCTAssertNotNil(response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_getCharacterDataResponse_noError_accpetableStatusCode_dataIncorrect_errors() {
        let response = HTTPURLResponse(url: URL(string: "fake")!, statusCode: 220, httpVersion: nil, headerFields: nil)
        let data = Data([0,1])
        mockURLSession.response = response
        mockURLSession.data = data
        let expectation = XCTestExpectation()
        subject.getCharacterDataResponse { (response) in
            XCTAssertNil(response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    // MARK: Testing Image Call
    
    func test_getcharacterImageResponse_respondsWithError_respondWithNilResponse() {
        mockURLSession.error = TestError.networkError

        let expectation = XCTestExpectation()
        subject.getCharacterImageResponse(from: "fake") { (response) in
            XCTAssertNil(response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func test_getCharacterImageResponse_respondsHTTPResponse_respondWithNilResponse() {
           let response = HTTPURLResponse(url: URL(string: "fake")!, statusCode: 180, httpVersion: nil, headerFields: nil)
           mockURLSession.response = response

           let expectation = XCTestExpectation()
        subject.getCharacterImageResponse(from: "fake") { response in
               XCTAssertNil(response)
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 1.0)
       }

    func test_getCharacterImageResponse_noError_accpetableStatusCode_dataCorrect_responseReceived() {
        //Need to find a way to get the image url faked / saved somewhere.
        let response = HTTPURLResponse(url: URL(string: "fake")!, statusCode: 220, httpVersion: nil, headerFields: nil)
        let image = UIImage(named: "ThreeChuffkateers")
        
        let data = image!.jpegData(compressionQuality: 0.0) //data is a UI image and when used in the method it is recognised as an image
        mockURLSession.response = response
        mockURLSession.data = data
        let expectation = XCTestExpectation()
        subject.getCharacterImageResponse(from: "fake") { (response) in
            XCTAssertNotNil(response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
   
    func test_getCharacterImageResponse_noError_accpetableStatusCode_dataIncorrect_errors() {
        let response = HTTPURLResponse(url: URL(string: "fake")!, statusCode: 220, httpVersion: nil, headerFields: nil)
         let testBundle = Bundle(for: CharacterListServiceTests.self)
         let url = testBundle.url(forResource: "mockresponse", withExtension: "json")
         let data = try? Data(contentsOf: url!)
        mockURLSession.response = response
        mockURLSession.data = nil
        let expectation = XCTestExpectation()
        subject.getCharacterImageResponse(from: "fake") { (response) in
            XCTAssertNil(response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
}

final class MockURLSession: URLSession {
    var error: Error?
    var response: HTTPURLResponse?
    var data: Data?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, response, error)
        return URLSessionDataTask()
    }
}

enum TestError: Error {
    case networkError
}
