//
//  CenterLayoutTests.swift
//  YogaFlexBoxKitTests
//
//  Created by Apple on 2019/5/27.
//  Copyright © 2019 zjade. All rights reserved.
//

import XCTest
import UIKit
@testable import YogaFlexBoxKit

class CenterLayoutTests: XCTestCase {
    func testTime() {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        for _ in 0..<20 {
            let width = CGFloat(Int(CGFloat.random(in: screenWidth/2...screenWidth)))
            let height = CGFloat(Int(CGFloat.random(in: screenWidth/2...screenHeight)))
            let size = CGSize(width: width, height: height)
            timerTest(true, size)
            timerTest(false, size)
            print("width：\(size.width) height：\(size.height)\n")
        }
    }
    func timerTest(_ value: Bool, _ size: CGSize) {
        isUseYogaLayout = value
        let view = UIView()
        let centerlayout = YogaFlexBoxKit.CenterLayoutTest()
        centerlayout.test(in: view, view.frame)
        
        let startTime = CFAbsoluteTimeGetCurrent()
        for _ in 0..<100 {
            centerlayout.reload(in: view)
        }
        let endTime = CFAbsoluteTimeGetCurrent()
        let diff1:Double = (endTime - startTime) * 1000
        print((value ? "yoga" : "layout") + " center " + String(diff1))
    }
    func testLayoutExample() {
        self.measure {
            for _ in 0..<100 {
                isUseYogaLayout.toggle()
                testCenter()
            }
        }
    }
    func testCenter() {
        let view = UIView()
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let width = CGFloat(Int(CGFloat.random(in: screenWidth/2...screenWidth)))
        let height = CGFloat(Int(CGFloat.random(in: screenHeight/2...screenHeight)))
        view.bounds.size = CGSize(width: width, height: height)
        let centerlayout = YogaFlexBoxKit.CenterLayoutTest()
        centerlayout.test(in: view, view.frame)
        centerlayout.reload(in: view)
        let itemRect = CGRect(origin: .zero, size: centerlayout.itemSize)
        for (offSet, layout) in view.layout.childs.enumerated() {
            var rect: CGRect = .zero
            rect.size.height = centerlayout.layoutHeight
            rect.size.width = width.pixelValue
            rect.origin.x = 0
            rect.origin.y = CGFloat(offSet) * rect.size.height
            XCTAssertTrue(layout.frame == rect, "layout位置错误\(layout.frame) != \(rect)")
            
            let item = (layout as! VirtualLayout).child as! ActualLayout
            var layoutRect = layout.frame
            layoutRect.origin = .zero
            switch centerlayout.array[offSet] {
            case .X:
                var rect: CGRect = itemRect
                rect.origin.x = (layoutRect.size.width - itemRect.size.width) / 2
                rect.origin.y = 0
                XCTAssertTrue(item.frame == rect, "X错误\(item.frame) != \(rect)")
            case .Y:
                var rect: CGRect = itemRect
                rect.origin.x = 0
                rect.origin.y = (layoutRect.size.height - itemRect.size.height) / 2
                XCTAssertTrue(item.frame == rect, "Y错误\(item.frame) != \(rect)")
            case .XY:
                var rect: CGRect = itemRect
                rect.origin.x = (layoutRect.size.width - itemRect.size.width) / 2
                rect.origin.y = (layoutRect.size.height - itemRect.size.height) / 2
                XCTAssertTrue(item.frame == rect, "XY错误\(item.frame) != \(rect)")
            }
        }
    }
}
