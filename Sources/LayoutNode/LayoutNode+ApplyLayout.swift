//
//  LayoutNode+ApplyLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/22.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
public struct YGDimensionFlexibility: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    static let flexibleWidth = YGDimensionFlexibility(rawValue: 1 << 0)
    static let flexibleHeight = YGDimensionFlexibility(rawValue: 1 << 1)
}
extension LayoutNode {
    func applyLayout(preserveOrigin: Bool, size: CGSize? = nil) {
        calculateLayout(with: size ?? layoutable.size)
        layoutable.applyLayoutToViewHierarchy(preserveOrigin: preserveOrigin)
    }
    func applyLayout(preserveOrigin: Bool, size: CGSize? = nil, dimensionFlexibility: YGDimensionFlexibility) {
        var size: CGSize = size ?? layoutable.size
        if dimensionFlexibility.contains(.flexibleWidth) {
            size.width = CGFloat.nan
        }
        if dimensionFlexibility.contains(.flexibleHeight) {
            size.height = CGFloat.nan
        }
        applyLayout(preserveOrigin: preserveOrigin, size: size)
    }
}
extension Layoutable {
    fileprivate func applyLayoutToViewHierarchy(preserveOrigin: Bool) {
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
        let origin = preserveOrigin ? self.frame.origin : .zero
        self.frame = CGRect(
            x: (topLeft.x + origin.x).pixelValue,
            y: (topLeft.y + origin.y).pixelValue,
            width: bottomRight.x.pixelValue - topLeft.x.pixelValue,
            height: bottomRight.y.pixelValue - topLeft.y.pixelValue
        )
        if !yoga.isLeaf {
            self.childs.forEach({$0.applyLayoutToViewHierarchy(preserveOrigin: false)})
        }
    }
}
