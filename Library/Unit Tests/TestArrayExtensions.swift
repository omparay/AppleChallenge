//
//  TestArrayextensions.swift
//
//  Created by Oliver Paray on 4/23/18.
//

import XCTest

class TestArrayExtensions: XCTestCase {
    
    var testArray1: Array<Any> = []
    var testArray2 = [1,2,3,4,5,6,7,8,9,10]
    var testArray3 = [1.1,2.2,3.3,4.4,5.5,6.6,7.7,8.8,9.9,10.10]
    var testArray4 = [1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0]
    
    override func setUp() {
        testArray1 = [22/7,0xFF,"Hello World!!!",CGRect(x: 0, y: 0, width: 8, height: 8),CGPoint(x: 16, y: 16),UIColor(htmlColor: "AABBCC") as Any,[1:"One",2:"Two",3:"Three"]]
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDeepCopy() {
        let copiedArray1 = testArray1.deepCopy()
        XCTAssertEqual(testArray1.count, copiedArray1.count)
        
        var copiedArray2 = testArray2.deepCopy()
        for item in testArray2{
            if !copiedArray2.contains(where: { $0 == item }){
                XCTFail("Missing item \(item) in copied array 2")
            }
            copiedArray2.remove(object: item)
            if copiedArray2.contains(where: { $0 == item }){
                XCTFail("\(item) was not removed from copied array 2")
            }
        }
        
        var copiedArray3 = testArray3.deepCopy()
        copiedArray3.remove(objects: testArray4)
        XCTAssertNotEqual(copiedArray3.count, 0)
        copiedArray3.remove(objects: testArray3)
        XCTAssertEqual(copiedArray3.count, 0)
    }
    
    func testCut(){
        var copiedArray4 = testArray4.deepCopy()
        if let cutArray = copiedArray4.cut(from: 3, to: 6){
            XCTAssertEqual(cutArray.count, 4)
            for item in copiedArray4{
                if cutArray.contains(where: { $0 == item }){
                    XCTFail("\(item) exists in both original and cut array")
                }
            }
        } else {
            XCTFail("Array cut failed")
        }
    }
    
    func testCommaDelminated(){
        let testResult1 = testArray3.commaDelimitedString
        XCTAssert(testResult1.last != ",", "Last character is still a comma")
        let testResult2 = testArray3.concatenatedString
        XCTAssert(!testResult2.contains(","), "Commas were not all removed")
    }
    
//    func testPerformanceExample() {
//        self.measure {
//        }
//    }
}
