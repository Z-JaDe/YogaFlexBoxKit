//
//  VirtualLayout+CalculateLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/30.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension VirtualLayout {
    func sizeThatFits(_ size: CGSize) -> CGSize {
        if child.yoga.isIncludedInLayout {
            return child.sizeThatFits(size) + edgesInset()
        } else {
            return .zero
        }
    }
    var intrinsicSize: CGSize {
        return self.calculateLayout(with: CGSize.nan)
    }
    @discardableResult
    func calculateLayout(with size: CGSize) -> CGSize {
        if isUseYogaLayout {
            return yoga.calculateLayout(with: size)
        }
        let size = size - edgesInset()
        let childSize = child.calculateLayout(with: size)
        __size = childSize + edgesInset()
        return __size
    }
    func layoutChildSize(_ oldSize: CGSize, _ containerSize: CGSize) -> CGSize {
        let nanSize = CGSize.nan
        var reSize = nanSize
        if oldSize.width > containerSize.width {
            reSize.width = containerSize.width
        }
        if oldSize.height > containerSize.height {
            reSize.height = containerSize.height
        }
        if reSize.isNaN == false {
            return calculateLayout(with: reSize)
        } else {
            return oldSize
        }
    }
    
    func applyLayoutToViewHierarchy(origin: CGPoint) {
        self._frame = CGRect(origin: origin, size: self.__size)
        self.child.applyLayoutToViewHierarchy(origin: layoutChildOrigin(self._frame, __size - edgesInset()))
    }
}
extension VirtualLayout: YogaCalculateLayoutable {
    var isScroll: Bool {
        return child.isScroll
    }
    var containerSize: CGSize {
        return child.containerSize + edgesInset()
    }
    func applyLayout(preserveOrigin: Bool, size: CGSize) {
        if isUseYogaLayout {
            yoga.applyLayout(preserveOrigin: preserveOrigin, size: size)
            return
        }
        let origin = preserveOrigin ? self._frame.origin : .zero
        /// 只计算frame,但是没有设置到_frame上
        calculateLayout(with: size)
        /// 更新到_frame上
        applyLayoutToViewHierarchy(origin: origin)
        /// 更新到 view的Frame上
        performInMainAsync {
            self.updateChildViewFrame()
        }
    }
}
