//
//  FruitsAPITest.swift
//  FruitApp
//
//  Created by Muneer KK on 07/08/21.
//
import XCTest
@testable import FruitApp

class FruitsAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDownloadFruit() {
        // Create an expectation for a API call.
        let expectation = XCTestExpectation(description: "Fetch fruit")
        
        FruitVM.loadFruits { (fruits, error) in
            if error != nil {
                XCTFail(error!.localizedDescription)
            }
            else  {
//                print(fruits)
            }
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
        }
        
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
}

