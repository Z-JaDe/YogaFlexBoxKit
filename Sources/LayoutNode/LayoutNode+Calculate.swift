//
//  LayoutNode+Size.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/22.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension LayoutNode {
    var intrinsicSize: CGSize {
        return calculateLayout(with: CGSize(width: CGFloat.nan, height: CGFloat.nan))
    }
    @discardableResult
    func calculateLayout(with size: CGSize) -> CGSize {
        layoutable.attachNodesFromViewHierachy()
        YGNodeCalculateLayout(yogaNode, Float(size.width), Float(size.height), self.direction)
        return CGSize(
            width: YGNodeLayoutGetWidth(yogaNode),
            height: YGNodeLayoutGetHeight(yogaNode)
        )
    }
}

extension LayoutNode {
    func hasExactSameChildren<C: Collection>(_ childs: C) -> Bool where C.Element: LayoutNode {
        if self.numberOfChildren != childs.count {
            return false
        }
        return childs.enumerated().allSatisfy({$0.element.yogaNode == self.getChild(UInt32($0.offset))})
    }
}
extension Layoutable {
    fileprivate func attachNodesFromViewHierachy() {
        let yoga = self.yoga
        if yoga.isLeaf {
            ///如果是叶子节点 移除所有子节点，并设置适配尺寸的方法
            yoga.removeAllChildren()
            yoga.setMeasureFunc(measureView)
            return
        }
        /// 如果不是叶子节点，移除适配尺寸的方法，移除不可用节点，并递归遍历所有子视图
        yoga.setMeasureFunc(nil)
        let subviewsToInclude = self.childs.lazy.map({$0.yoga}).filter({$0.isIncludedInLayout})
        if yoga.hasExactSameChildren(subviewsToInclude) == false {
            yoga.removeAllChildren()
            subviewsToInclude.enumerated().forEach({yoga.insertChild($0.element, index: UInt32($0.offset))})
        }
        subviewsToInclude.forEach({$0.layoutable?.attachNodesFromViewHierachy()})
    }
}
