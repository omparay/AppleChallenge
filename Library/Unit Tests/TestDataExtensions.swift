//
//  TestDataExtensions.swift
//
//  Created by Oliver Paray on 4/19/18.
//

import XCTest

class TestDataExtensions: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSHA256Hash() {
        let testString = "Password"
        let hashedData = "E7CF3EF4F17C3999A94F2C6F612E8A888E5B1026878E4E19398B23BD38EC221A"
        let expectedResult = hashedData.lowercased()
        if let testData = testString.data(using: .utf8){
            XCTAssertEqual(testData.sha256Hash(), expectedResult)
        } else {
            XCTFail("Problem converting test string into data")
        }
    }
    
//    func testPerformanceExample() {
//        self.measure {
//        }
//    }    
}
