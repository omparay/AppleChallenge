//
//  TestDateExtensions.swift
//
//  Created by Oliver Paray on 4/19/18.
//

import XCTest

class TestDateExtensions: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDateFromStringAndWeekday() {
        if let testDate = Date.from(string: "04/15/2018", format: "MM/dd/yyyy"){
            XCTAssertEqual(testDate.weekday.dayOfWeek, 1)
            XCTAssertEqual(testDate.weekday.name, "Sunday")
        } else {
            XCTFail("Bad date from string")
        }
    }
    
    func testDateToString(){
        let testDate1 = Date.now
        let expectedResult1 = String(format: "%02d/%02d/%04d",testDate1.month,testDate1.day,testDate1.year)
        let expectedResult2 = String(format: "%02d:%02d:%02d",testDate1.hour,testDate1.minute,testDate1.second)
        let expectedResult3 = String(format: "%02d:%02d:%02d",testDate1.militaryHour,testDate1.minute,testDate1.second)
        let expectedResult4 = String(format: "%02d:%02d %@",testDate1.hour,testDate1.minute,(testDate1.militaryHour>=12) ? "PM":"AM")
        XCTAssertEqual(expectedResult1, testDate1.toString(usingFormat: "MM/dd/yyyy"))
        XCTAssertEqual(expectedResult2, testDate1.toString(usingFormat: "hh:mm:ss"))
        XCTAssertEqual(expectedResult3, testDate1.toString(usingFormat: "HH:mm:ss"))
        XCTAssertEqual(expectedResult4, testDate1.toString(usingFormat: "hh:mm a"))
        
        if let testDate2 = Date.from(string: "04/15/2018 00:00:00", format: "MM/dd/yyyy HH:mm:ss"){
            let expectedResult5 = String(format: "%02d:%02d %@",testDate2.hour,testDate2.minute,(testDate2.militaryHour>=12) ? "PM":"AM")
            XCTAssertEqual(expectedResult5, testDate2.toString(usingFormat: "hh:mm a"))
        } else {
            XCTFail("Bad date from string")
        }

        if let testDate3 = Date.from(string: "04/15/2018 12:00:00", format: "MM/dd/yyyy HH:mm:ss"){
            let expectedResult6 = String(format: "%02d:%02d %@",testDate3.hour,testDate3.minute,(testDate3.militaryHour>=12) ? "PM":"AM")
            XCTAssertEqual(expectedResult6, testDate3.toString(usingFormat: "hh:mm a"))
        } else {
            XCTFail("Bad date from string")
        }

    }
    
//    func testPerformanceExample() {
//        self.measure {
//        }
//    }    
}
