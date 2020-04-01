//
//  TestDictionaryExtensions.swift
//
//  Created by Oliver Paray on 4/23/18.
//

import XCTest

class TestDictionaryExtensions: XCTestCase {
    
    var testDictionary1 = [1:"One",2:"Two",3:"Three",4:"Four",5:"Five"]
    var testDictionary2 = [6:"Six",7:"Seven",8:"Eight",9:"Nine",10:"Ten"]
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDeepCopy() {
        let copiedDict1 = testDictionary1.deepCopy()
        for (key,value) in testDictionary1{
            XCTAssertTrue(copiedDict1.containsKey(key))
            XCTAssertTrue(copiedDict1[key] == value)
        }
    }
    
    func testMerge(){
        let mergedDict = testDictionary1.merged(with: testDictionary2)
        for (key,value) in testDictionary1{
            XCTAssertTrue(mergedDict.containsKey(key))
            XCTAssertTrue(mergedDict[key] == value)
        }
        for (key,value) in testDictionary2{
            XCTAssertTrue(mergedDict.containsKey(key))
            XCTAssertTrue(mergedDict[key] == value)
        }
    }
    
//    func testPerformanceExample() {
//        self.measure {
//        }
//    }
}
