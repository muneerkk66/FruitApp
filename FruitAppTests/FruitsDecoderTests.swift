//
//  FruitsDecoder.swift
//  FruitAppTests
//
//  Created by Muneer KK on 07/08/21.
//

import XCTest
@testable import FruitApp
class FruitsDecoderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    var jsonResponse : String {
        return """
        {
            "fruit":[
                {"type":"apple", "price":149, "weight":120},
                {"type":"banana", "price":129, "weight":80},
                {"type":"blueberry", "price":19, "weight":18},
                {"type":"orange", "price":199, "weight":150},
                {"type":"pear", "price":99, "weight":100},
                {"type":"strawberry", "price":99, "weight":20},
                {"type":"kumquat", "price":49, "weight":80},
                {"type":"pitaya", "price":599, "weight":100},
                {"type":"kiwi", "price":89, "weight":200}
            ]
        }
        """
    }
    
    func testDecodeHeadlines() {
        let data: Data? = jsonResponse.data(using: .utf8)
        
        do {
            let fruits = try FruitsDecoders.decodeJSON(data: data!, type: Fruits.self)
            let expected = 9
            let result = fruits?.fruit.count ?? 0
            print(result)
            XCTAssert(expected == result, "Test failed: tell me what you want")
        } catch let e {
            XCTFail("Test failed: \(e.localizedDescription)")
        }
    }
    
}
