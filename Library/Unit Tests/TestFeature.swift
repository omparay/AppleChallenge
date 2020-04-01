//
//  TestFeature.swift
//
//  Created by Oliver Paray on 6/15/18.
//

import XCTest

public enum Features:String{
    case activity,answer,application,assignment,entry,journal,lesson,notification,profile,question,report,resource

    public static let allValues = [activity,answer,application,assignment,entry,journal,lesson,notification,profile,question,report,resource]
}

class TestFeature: XCTestCase {
    
    var jsonData:JSON?
    var testBundle: Bundle?

    override func setUp() {
        testBundle = Bundle(for: type(of: self))
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test1Loading() {
        if let fileSpec = testBundle!.url(forResource: "FeatureTestData", withExtension: "json"){
            if let jsonData = Parser.jsonFrom(url: fileSpec){
                if let testKey = jsonData.allKeys.first as? String{

                    Feature.load(features: jsonData)

                    XCTAssertNotNil(UserDefaults.standard.value(forKey: testKey), "Feature Data Not Saved!!!")
                } else {
                    XCTFail("Invalid json data!!!")
                }
            } else {
                XCTFail("Could not load json data!!!")
            }
        } else {
            XCTFail("Could not get path to test file!!!")
        }
    }

    func test2Validation(){
        for feature in Features.allValues{
            XCTAssertNotNil(UserDefaults.standard.value(forKey: feature.rawValue), "Feature '\(feature)' Data Not Saved!!!")

            XCTAssertTrue(Feature.isEnabled(forItem: feature.rawValue))
        }
    }


//    func testPerformanceExample() {
//        self.measure {
//        }
//    }

}
