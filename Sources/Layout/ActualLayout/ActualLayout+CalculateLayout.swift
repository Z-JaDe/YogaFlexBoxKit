//
//  ActualLayout+CalculateLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/30.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension ActualLayout: YogaCalculateLayoutable {
    func sizeThatFits(_ size: CGSize) -> CGSize {
        return view!.sizeThatFits(size)
    }
    var intrinsicSize: CGSize {
        return self.calculateLayout(with: CGSize.nan)
    }
    @discardableResult
    func calculateLayout(with size: CGSize) -> CGSize {
        var size: CGSize = size
        if isScroll {
            if self.containerSize.width.isNaN == false {
                size.width = containerSize.width
            }
            if self.containerSize.height.isNaN == false {
                size.height = containerSize.height
            }
        }
        return yoga.calculateLayout(with: size)
    }
    func applyLayoutToViewHierarchy(origin: CGPoint) {
        yoga.applyLayoutToViewHierarchy(origin: origin)
    }
    func applyLayout(preserveOrigin: Bool, size: CGSize) {
        var size = size
        if isScroll {
            size.height = CGFloat.nan
        }
        let origin = preserveOrigin ? self.frame.origin : .zero
        /// 只计算frame,但是没有设置到_frame上
        calculateLayout(with: size)
        /// 更新到_frame上
        applyLayoutToViewHierarchy(origin: origin)
        /// 更新到 view的Frame上
        performInMainAsyncIfNeed {
            self.updateChildViewFrame()
        }
    }
}
