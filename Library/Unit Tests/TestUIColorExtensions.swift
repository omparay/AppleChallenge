//
//  TestUIColorExtensions.swift
//
//  Created by Oliver Paray on 4/19/18.
//

import XCTest

class TestUIColorExtensions: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testColorInitialization() {
        let colorString = "004488FF"
        let expectedResult1 = "004488"
        if let testColor = UIColor(htmlColor: colorString){
            let resultSet = testColor.rgba
            XCTAssertEqual(resultSet.red, 0, accuracy: 0.000000001, "Red should be 0.0")
            XCTAssertEqual(resultSet.green, 0.266666666666667, accuracy: 0.000000001, "Green should be 0.266666666666667")
            XCTAssertEqual(resultSet.blue, 0.533333333333333, accuracy: 0.000000001, "Blue should be 0.533333333333333")
            XCTAssertEqual(resultSet.alpha, 1, accuracy: 0.000000001, "Alpha should be 1.0")
            XCTAssertEqual(testColor.htmlColor, expectedResult1, "Expected 004488")
        } else {
            XCTFail("Initialization from string failed")
        }
    }
    
//    func testPerformanceExample() {
//        self.measure {
//        }
//    }    
}
