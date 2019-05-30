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
    func calculateLayout(with size: CGSize) -> CGSize {
        return child.yoga.calculateLayout(with: size) + edgesInset()
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
}
extension VirtualLayout: YogaCalculateLayoutable {
    var isScroll: Bool {
        return child.isScroll
    }
    func applyLayout(preserveOrigin: Bool, size: CGSize) {
        var size = size - edgesInset()
        if isScroll {
            size.height = CGFloat.nan
        }
        let childSize = child.yoga.calculateLayout(with: size)
        let origin = preserveOrigin ? self._frame.origin : .zero
        self._frame.size = childSize + edgesInset()
        self._frame.origin = origin
        ///这里 要递归处理 containerSize
        child.yoga.applyLayoutToViewHierarchy(origin: layoutChildOrigin(self._frame, childSize))
        self.updateChildViewFrame()
    }
}
