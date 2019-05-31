//
//  LayoutNode+ApplyLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/22.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension LayoutNode {
    func applyLayoutToViewHierarchy(origin: CGPoint) {
        layoutable.applyLayoutToViewHierarchy(origin: origin)
    }
    func applyLayout(preserveOrigin: Bool, size: CGSize) {
        calculateYogaLayout(with: size)
        applyLayoutToViewHierarchy(origin: preserveOrigin ? self.layoutable.frame.origin : .zero)
    }
}
extension YogaLayoutable {
    fileprivate func applyLayoutToViewHierarchy(origin: CGPoint) {
        assertInMain()
        let yoga = self.yoga
        guard yoga.isIncludedInLayout else { return }
        let node = yoga.yogaNode
        let topLeft: CGPoint = CGPoint(
            x: YGNodeLayoutGetLeft(node),
            y: YGNodeLayoutGetTop(node)
        )
        let bottomRight: CGPoint = CGPoint(
            x: topLeft.x + CGFloat(YGNodeLayoutGetWidth(node)),
            y: topLeft.y + CGFloat(YGNodeLayoutGetHeight(node))
        )
        let origin = origin
        let frame = CGRect(
            x: (topLeft.x + origin.x).pixelValue,
            y: (topLeft.y + origin.y).pixelValue,
            width: bottomRight.x.pixelValue - topLeft.x.pixelValue,
            height: bottomRight.y.pixelValue - topLeft.y.pixelValue
        )
        self.applyFrame(frame)
        if !yoga.isLeaf {
            self.childs.forEach({$0.applyLayoutToViewHierarchy(origin: .zero)})
        }
    }
    func applyFrame(_ frame: CGRect) {
        if let layout = self as? RenderLayout {
            layout.changePrivateFrame(frame)
        } else if let view = self as? UIView {
            assertionFailure("目前没有这种情况")
            view.frame = frame
        }
    }
}
