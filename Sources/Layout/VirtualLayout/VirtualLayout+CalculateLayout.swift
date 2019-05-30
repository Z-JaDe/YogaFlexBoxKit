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
        return child.sizeThatFits(size) + edgesInset()
    }
    var intrinsicSize: CGSize {
        return self.calculateLayout(with: CGSize.nan)
    }
    func calculateLayout(with size: CGSize) -> CGSize {
        return child.yoga.calculateLayout(with: size) + edgesInset()
    }
    func layoutChildSize(_ oldSize: CGSize, newFrame: CGRect) -> CGSize {
        let nanSize = CGSize.nan
        var reSize = nanSize
        if oldSize.width > newFrame.size.width {
            reSize.width = newFrame.size.width
        }
        if oldSize.height > newFrame.size.height {
            reSize.height = newFrame.size.height
        }
        if reSize.isNaN == false {
            return calculateLayout(with: oldSize)
        } else {
            return oldSize
        }
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
        var size = size - edgesInset()
        if isScroll {
            size.height = CGFloat.nan
        }
        let childSize = child.yoga.calculateLayout(with: size)
        let origin = preserveOrigin ? self._frame.origin : .zero
        self._frame.size = childSize + edgesInset()
        self._frame.origin = origin

        child.yoga.applyLayoutToViewHierarchy(origin: layoutChildOrigin(self._frame, childSize))
        self.updateChildViewFrame()
    }
}
