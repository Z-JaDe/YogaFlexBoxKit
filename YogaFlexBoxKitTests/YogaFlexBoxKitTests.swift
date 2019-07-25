//
//  YogaFlexBoxKitTests.swift
//  YogaFlexBoxKitTests
//
//  Created by Apple on 2019/5/21.
//  Copyright © 2019 zjade. All rights reserved.
//

import XCTest
@testable import YogaFlexBoxKit

class YogaFlexBoxKitTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

}
extension CGRect {
    func aboutEqual(_ rect: CGRect) -> Bool {
        if self.origin.x - rect.origin.x > 1 {
            return false
        }
        if self.origin.y - rect.origin.y > 1 {
            return false
        }
        if self.size.width - rect.size.width > 1 {
            return false
        }
        if self.size.height - rect.size.height > 1 {
            return false
        }
        return true
    }
}
