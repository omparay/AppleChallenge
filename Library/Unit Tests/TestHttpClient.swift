//
//  Unit_Tests.swift
//  Unit Tests
//
//  Created by Oliver Paray on 6/24/19.
//  Copyright © 2019 Oliver Paray. All rights reserved.
//

import XCTest

class TestHttpClient: XCTestCase {

    static let docid = NSUUID().uuidString
    var testBundle:Bundle?

    override func setUp() {
        testBundle = Bundle(for: type(of: self))
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test1SimpleSearch() {
        let received = expectation(description: "Simple Search")

        HttpClient.sharedInstance.execute(serviceUrl: "https://itunes.apple.com/search?term=jack+johnson",
                                          webMethod: .Get,
                                          executionHandler:
            (success:{
                (response,data) in
                if let httpResponse = response as? HTTPURLResponse, let httpData = data{
                    if httpResponse.statusCode != 200{
                        XCTFail("Returned status code: \(httpResponse.statusCode)")
                        received.fulfill()
                    }
                    if let jsonString = String(data: httpData, encoding: String.Encoding.utf8){
                        XCTAssertNotEqual(jsonString, "")
                        print("Recieved JSON:\n\(jsonString)\n")
                        received.fulfill()
                    } else {
                        XCTFail("Could not decode expected JSON")
                        received.fulfill()
                    }
                } else {
                    XCTFail("No response or data")
                    received.fulfill()
                }
            },failure:{
                (response,error,message) in
                if let errorMessage = message{
                    XCTFail(errorMessage)
                    received.fulfill()
                }
            })
        )

        wait(for: [received], timeout: 5.0)
    }

    func test2iTunesSearch() {
        let received = expectation(description: "iTunes Search")

        iTunesSearch.performSearch(withTerm: "regex", handler:
            (success: {
                (response,data) in
                if let httpResponse = response as? HTTPURLResponse, let httpData = data{
                    if httpResponse.statusCode != 200{
                        XCTFail("Returned status code: \(httpResponse.statusCode)")
                        received.fulfill()
                    }
                    if let jsonString = String(data: httpData, encoding: String.Encoding.utf8){
                        XCTAssertNotEqual(jsonString, "")
                        print("Recieved JSON:\n\(jsonString)\n")
                        received.fulfill()
                    } else {
                        XCTFail("Could not decode expected JSON")
                        received.fulfill()
                    }
                } else {
                    XCTFail("No response or data")
                    received.fulfill()
                }
            }, failure: {
                (response,error,message) in
                if let errorMessage = message{
                    XCTFail(errorMessage)
                    received.fulfill()
                }
            })
        )

        wait(for: [received], timeout: 5.0)

        for value in iTunesSearch.CountryKeys.allCases {
            print(value)
        }
    }
}
