//
//  TestStringExtensions.swift
//
//  Created by Oliver Paray on 4/18/18.
//

import XCTest

class TestStringExtensions: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSHAHash() {
        let testString = "Password"
        let hashedString = "E7CF3EF4F17C3999A94F2C6F612E8A888E5B1026878E4E19398B23BD38EC221A"
        let expectedResult = hashedString.lowercased()
        let result = testString.sha256Hash()
        XCTAssertEqual(expectedResult, result)
    }
    
    func testQueryStringFromDictionary(){
        let testDictionary1 = ["param1":"value1","param2":"value2","param3":"value3","param4":"value4","param5":"value5"]
        let testString1 = String(queryStringFromDictionary: testDictionary1)
        for (key,value) in testDictionary1{
            if testString1.contains(key) && testString1.contains(value){

            } else {
                XCTFail("Missing \(key):\(value)")
            }
        }
        let testDictionary2 = ["param1":"value1","param2":1,"param3":2.0,"param4":0b110001,"param5":0xABCDEF] as [String : Any]
        let testString2 = String(queryStringFromDictionary: testDictionary2)
        for (key,value) in testDictionary2{
            if testString2.contains(key) && testString2.contains(String(describing: value)){

            } else {
                XCTFail("Missing \(key):\(value)")
            }
        }
    }
    
    func testSubString(){
        let testValue = "<<<HOME>>>"
        let expectedResult1 = ">>>"
        let expectedResult2 = "<<<"
        let expectedResult3 = "HOME"
        XCTAssertEqual(testValue.subString(start: 7), expectedResult1)
        XCTAssertEqual(testValue.subString(end: 3), expectedResult2)
        XCTAssertEqual(testValue.subString(start: 4, end: 7), expectedResult3)
    }
    
//    func testPerformanceExample() {
//        self.measure {
//        }
//    }    
}
