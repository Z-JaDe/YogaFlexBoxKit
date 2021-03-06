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
    func testLayoutExample() {
        self.measure {
            var isUseYogaLayout = false
            for _ in 0..<100 {
                isUseYogaLayout.toggle()
                testCenter(isUseYoga: isUseYogaLayout)
            }
        }
    }
    func testCenter(isUseYoga: Bool) {
        let view = UIView()
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let width = CGFloat(Int(CGFloat.random(in: screenWidth/2...screenWidth)))
        let height = CGFloat(Int(CGFloat.random(in: screenHeight/2...screenHeight)))
        view.bounds.size = CGSize(width: width, height: height)
        let centerlayout = YogaFlexBoxKit.CenterLayoutTest()
        centerlayout.test(in: view)
        centerlayout.reload(in: view, size: CGSize(width: width, height: height))
        let itemRect = CGRect(origin: .zero, size: centerlayout.itemSize)
        for (offSet, layout) in view.childs.enumerated() {
            var rect: CGRect = .zero
            rect.size.height = centerlayout.layoutHeight
            rect.size.width = width.pixelValue
            rect.origin.x = 0
            rect.origin.y = CGFloat(offSet) * rect.size.height
            XCTAssertTrue(layout.getFrame() == rect, "layout位置错误\(layout.getFrame()) != \(rect)")
            
            let item = (layout as! VirtualLayout).child
            var layoutRect = layout.getFrame()
            layoutRect.origin = .zero
            switch centerlayout.array[offSet] {
            case .X:
                var rect: CGRect = itemRect
                rect.origin.x = (layoutRect.size.width - itemRect.size.width) / 2
                rect.origin.y = 0
                XCTAssertTrue(item.getFrame().aboutEqual(rect), "X错误\(item.getFrame()) != \(rect)")
            case .Y:
                var rect: CGRect = itemRect
                rect.origin.x = 0
                rect.origin.y = (layoutRect.size.height - itemRect.size.height) / 2
                XCTAssertTrue(item.getFrame().aboutEqual(rect), "Y错误\(item.getFrame()) != \(rect)")
            case .XY:
                var rect: CGRect = itemRect
                rect.origin.x = (layoutRect.size.width - itemRect.size.width) / 2
                rect.origin.y = (layoutRect.size.height - itemRect.size.height) / 2
                XCTAssertTrue(item.getFrame().aboutEqual(rect), "XY错误\(item.getFrame()) != \(rect)")
            }
        }
    }
}
