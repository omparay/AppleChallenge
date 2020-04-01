//
//  TestParser.swift
//
//  Created by Oliver Paray on 4/24/18.
//

import XCTest

class TestParser: XCTestCase {
    
    var jsonData:JSON?
    var testBundle: Bundle?
    
    override func setUp() {
        testBundle = Bundle(for: type(of: self))
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParser() {
        if let fileSpec = testBundle?.url(forResource: "ParserTestData", withExtension: "json"){
            if let parsedData = Parser.jsonFrom(url: fileSpec){
                print("Parsed Data: \n\(parsedData)\n")
            }else{
                XCTFail("Could not parse the data file!!!")
            }
        }else{
            XCTFail("Could not get path to test file!!!")
        }
    }
        
//    func testPerformanceExample() {
//        self.measure {
//        }
//    }
    
}
