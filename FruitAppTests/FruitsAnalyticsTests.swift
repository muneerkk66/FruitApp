//
//  FruitsAnalyticsTest.swift
//  FruitAppTests
//
//  Created by Muneer KK on 07/08/21.
//

import XCTest
@testable import FruitApp
class FruitsAnalyticsTests: XCTestCase {
        
        override func setUp() {
            super.setUp()
            // Put setup code here. This method is called before the invocation of each test method in the class.
        }
        
        override func tearDown() {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
            super.tearDown()
        }
        
        func testFruitsAnalyticsToURL() {
            
            let property = EventProperty(name: "time", value: "\(123)")
            let event = FruitsAnalyticsEvent(event: .load, metaData: [property], date: Date())
            
            let baseURL = URL(string: AppConstants.Configuration.baseURL(path: "analytics"))!
            
            let url = event.url(baseURL: baseURL)
            let result = url?.absoluteString
            let expected = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/analytics?event=load&time=123"
            
            XCTAssert(expected == result, "Test failed: tell me what you want")
        }
        
        func testUploadAnalytics() {
            // Create an expectation for a API call.
            let expectation = XCTestExpectation(description: "Upload analytics")
            FruitAnalytics.start()
            
            let property = EventProperty(name: "time", value: "\(123)")
            FruitAnalytics.trackEvent(event: .load, metaData: [property])
            
            let delay = 15.0
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                // Fulfill the expectation to indicate that the background task has finished successfully.
                expectation.fulfill()
            }
            
            // Wait until the expectation is fulfilled, with a timeout of 20 seconds.
            wait(for: [expectation], timeout: 20.0)
        }
        
    }

