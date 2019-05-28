//
//  CornerLayoutTests.swift
//  YogaFlexBoxKitUITests
//
//  Created by Apple on 2019/5/27.
//  Copyright © 2019 zjade. All rights reserved.
//

import XCTest
import UIKit
@testable import YogaFlexBoxKit

class CornerLayoutTests: XCTestCase {
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
        let cornerlayout = YogaFlexBoxKit.CornerLayoutTest()
        cornerlayout.test(in: view, CGRect(origin: .zero, size: size))
        
        let startTime = CFAbsoluteTimeGetCurrent()
        for _ in 0..<100 {
            cornerlayout.reload(in: view)
        }
        let endTime = CFAbsoluteTimeGetCurrent()
        let diff1:Double = (endTime - startTime) * 1000
        print((value ? "yoga" : "layout") + " corner " + String(diff1))
    }
    func testLayoutExample() {
        self.measure {
            for _ in 0..<100 {
                isUseYogaLayout.toggle()
                testCorner()
            }
        }
    }
    func testCorner() {
        let view = UIView()
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let width = CGFloat(Int(CGFloat.random(in: screenWidth/2...screenWidth)))
        let height = CGFloat(Int(CGFloat.random(in: screenWidth/2...screenHeight)))
        let cornerlayout = YogaFlexBoxKit.CornerLayoutTest()
        cornerlayout.test(in: view, CGRect(origin: .zero, size: CGSize(width: width, height: height)))
        cornerlayout.reload(in: view)
        let itemRect = CGRect(origin: .zero, size: cornerlayout.itemSize)
        for (offSet, layout) in view.layout.childs.enumerated() {
            var rect: CGRect = .zero
            rect.size.height = cornerlayout.layoutHeight
            rect.size.width = (width / 2).pixelValue
            rect.origin.x = CGFloat(offSet % 2) * rect.size.width
            rect.origin.y = CGFloat(offSet / 2) * rect.size.height
            XCTAssertTrue(layout.frame == rect, "layout位置错误\(layout.frame) != \(rect)")
            
            let item = (layout as! VirtualLayout).child as! ActualLayout
            var layoutRect = layout.frame
            layoutRect.origin = .zero
            switch cornerlayout.array[offSet] {
            case .topLeft(let top, let left):
                var rect: CGRect = itemRect
                rect.origin.x = left
                rect.origin.y = top
                XCTAssertTrue(item.frame == rect, "topLeft错误\(item.frame) != \(rect)")
            case .topRight(let top, let right):
                var rect: CGRect = itemRect
                rect.origin.x = layoutRect.size.width - right - rect.size.width
                rect.origin.y = top
                XCTAssertTrue(item.frame == rect, "topRight错误\(item.frame) != \(rect)")
            case .bottomLeft(let bottom, let left):
                var rect: CGRect = itemRect
                rect.origin.x = left
                rect.origin.y = layoutRect.size.height - bottom - rect.size.height
                XCTAssertTrue(item.frame == rect, "bottomLeft错误\(item.frame) != \(rect)")
            case .bottomRight(let bottom, let right):
                var rect: CGRect = itemRect
                rect.origin.x = layoutRect.size.width - right - rect.size.width
                rect.origin.y = layoutRect.size.height - bottom - rect.size.height
                XCTAssertTrue(item.frame == rect, "bottomRight错误\(item.frame) != \(rect)")
                
            case .topFill(let offSet, let fillOffset):
                var rect: CGRect = layoutRect
                rect.size.width -= fillOffset * 2
//                if rect.size.width < itemRect.size.width {
//                    rect.size.width = itemRect.size.width
//                }
                rect.size.height = itemRect.size.height
                rect.origin.x = fillOffset
                rect.origin.y = offSet
                XCTAssertTrue(item.frame == rect, "topFill错误\(item.frame) != \(rect)")
            case .bottomFill(let offSet, let fillOffset):
                var rect: CGRect = layoutRect
                rect.size.width -= fillOffset * 2
//                if rect.size.width < itemRect.size.width {
//                    rect.size.width = itemRect.size.width
//                }
                rect.size.height = itemRect.size.height
                rect.origin.x = fillOffset
                rect.origin.y = layoutRect.size.height - offSet - rect.size.height
                XCTAssertTrue(item.frame == rect, "bottomFill错误\(item.frame) != \(rect)")
            case .leftFill(let offSet, let fillOffset):
                var rect: CGRect = layoutRect
                rect.size.width = itemRect.size.width
                rect.size.height -= fillOffset * 2
                if rect.size.height < itemRect.size.height {
                    rect.size.height = itemRect.size.height
                }
                rect.origin.x = offSet
                rect.origin.y = fillOffset
                XCTAssertTrue(item.frame == rect, "leftFill错误\(item.frame) != \(rect)")
            case .rightFill(let offSet, let fillOffset):
                var rect: CGRect = layoutRect
                rect.size.width = itemRect.size.width
                rect.size.height -= fillOffset * 2
                if rect.size.height < itemRect.size.height {
                    rect.size.height = itemRect.size.height
                }
                rect.origin.x = layoutRect.size.width - offSet - rect.size.width
                rect.origin.y = fillOffset
                XCTAssertTrue(item.frame == rect, "rightFill错误\(item.frame) != \(rect)")
            }
        }
    }
}
