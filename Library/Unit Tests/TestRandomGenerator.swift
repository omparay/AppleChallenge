//
//  TestRandomGenerator.swift
//  Unit Tests
//
//  Created by Oliver Paray on 6/24/19.
//  Copyright © 2019 Oliver Paray. All rights reserved.
//

import XCTest

class TestRandomGenerator: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testRandomDouble() {
        for _ in 1...1024{
            let result = Random.double(min: 0.0001, max: 99.9999)
            XCTAssert(result != 0, "Result was still equal to zero!!!")
            XCTAssert(result != 100, "Result was still equal to 100!!!")
            XCTAssert((0.0001...99.9999).contains(result), "Result was not in the expected range!!!")
        }
    }

    func testRandomFloat() {
        for _ in 1...1024{
            let result = Random.float(min: 0.01, max: 99.99)
            XCTAssert(result != 0, "Result was still equal to zero!!!")
            XCTAssert(result != 100, "Result was still equal to 100!!!")
            XCTAssert((0.01...99.99).contains(result), "Result was not in the expected range!!!")
        }
    }

    func testRandomInt(){
        for _ in 1...1024{
            let result = Random.int(min: 1, max: 99)
            XCTAssert(result != 0, "Result was still equal to zero!!!")
            XCTAssert(result != 100, "Result was still equal to 100!!!")
            XCTAssert((1...99).contains(result), "Result was not in the expected range!!!")
        }
    }
}
