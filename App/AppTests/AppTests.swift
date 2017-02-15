//
//  AppTests.swift
//  AppTests
//
//  Created by Joshua Thompson on 14/02/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import XCTest
@testable import App

class AppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testErrorMesages() {
        
        let expectation = self.expectation(description: "asynchronous request")

        Constants.httpRequestManager.requestForProducers(page: 1) { (dictionary: NSDictionary, error) in
            
            //Test internet connection
            XCTAssertNil(error, (error?.localizedDescription)!)
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testNilOrEmptyLocation() {
        
        let expectation = self.expectation(description: "asynchronous request")
        
        Constants.httpRequestManager.requestForProducers(page: 1) { (dictionary: NSDictionary, error) in
            
            let arrProducers = dictionary["response"] as! NSArray
            
            for dictObject in arrProducers {
                
                let dictProducer = (dictObject as! NSDictionary)

                print(dictProducer["location"] as! String)
                
                //Test No locations
                XCTAssertNotNil(dictProducer["location"] as? String, "Location is nil")
                
                //Test if location value is empty
                XCTAssertNotEqual(dictProducer["location"] as! String, "", "Location does not exist for this producer")
            }
        
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testAtLeastOneImage() {
        
        let expectation = self.expectation(description: "asynchronous request")
        
        Constants.httpRequestManager.requestForProducers(page: 1) { (dictionary: NSDictionary, error) in
            
            let arrProducers = dictionary["response"] as! NSArray
            
            for dictObject in arrProducers {
                
                let dictProducer = (dictObject as! NSDictionary)
                
                print(dictProducer["location"] as! String)
                
                //Test for at least one image
                XCTAssertGreaterThanOrEqual((dictProducer["images"] as! NSArray).count, 1, "Array should have at least one image")
            }
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
}
