//
//  TestMetrics.swift
//
//  Created by Oliver Paray on 5/21/18.
//

import XCTest

public enum TestActionEvent:String{
    case close,create,finish,open,search,select,start

    static let allValues = [close,create,finish,open,search,select,start]
}

class TestMetrics: XCTestCase {

    var testExpectations:[XCTestExpectation]?
    var testTable:NotificationTable?

    override class func setUp(){
        super.setUp()
    }

    override class func tearDown(){
        super.tearDown()
    }
    
    override func setUp() {
       testExpectations  = [
            XCTestExpectation(description: TestActionEvent.close.rawValue),
            XCTestExpectation(description: TestActionEvent.create.rawValue),
            XCTestExpectation(description: TestActionEvent.finish.rawValue),
            XCTestExpectation(description: TestActionEvent.open.rawValue),
            XCTestExpectation(description: TestActionEvent.search.rawValue),
            XCTestExpectation(description: TestActionEvent.select.rawValue),
            XCTestExpectation(description: TestActionEvent.start.rawValue)
        ]

        testTable = [
            (event:TestActionEvent.close.rawValue,
             object:self,
             handler:{ (notification) in
                print("Recieved Notification:\(notification.name.rawValue)")
                self.testExpectations![0].fulfill()
            }),
            (event: TestActionEvent.create.rawValue,
             object: self,
             handler: { (notification) in
                print("Recieved Notification:\(notification.name.rawValue)")
                self.testExpectations![1].fulfill()
            }),
            (event: TestActionEvent.finish.rawValue,
             object: self,
             handler: { (notification) in
                print("Recieved Notification:\(notification.name.rawValue)")
                self.testExpectations![2].fulfill()
            }),
            (event: TestActionEvent.open.rawValue,
             object: self,
             handler: { (notification) in
                print("Recieved Notification:\(notification.name.rawValue)")
                self.testExpectations![3].fulfill()
            }),
            (event: TestActionEvent.search.rawValue,
             object: self,
             handler: { (notification) in
                print("Recieved Notification:\(notification.name.rawValue)")
                self.testExpectations![4].fulfill()
            }),
            (event: TestActionEvent.select.rawValue,
             object: self,
             handler: { (notification) in
                print("Recieved Notification:\(notification.name.rawValue)")
                self.testExpectations![5].fulfill()
            }),
            (event: TestActionEvent.start.rawValue,
             object: self,
             handler: { (notification) in
                print("Recieved Notification:\(notification.name.rawValue)")
                self.testExpectations![6].fulfill()
            })
        ]

        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test1TableCreation() {

        let testResult = Metrics(withQueue: nil, andActionTable: testTable)

        XCTAssertEqual(testResult.observerTable.count, testTable!.count, "Mismatch table count!!!")
    }

    func testTableExecution(){

        let testQueue = DispatchQueue(label: "com.ues")

        let testResult = Metrics(withQueue: testQueue, andActionTable: testTable)

        XCTAssertEqual(testResult.observerTable.count, testTable!.count, "Mismatch table count!!!")

        testTable!.removeAll()

        for item in TestActionEvent.allValues{
            print("Sending Notification:\(item.rawValue)")
            NotificationCenter.default.post(name: Notification.Name(item.rawValue), object: self)
        }

        wait(for: testExpectations!, timeout: 60)
    }
    
//    func testPerformanceExample() {
//        self.measure {
//        }
//    }
    
}
