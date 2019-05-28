//
//  VirtualLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
internal var isUseYogaLayout: Bool = true
///本身并不包含view 但是可以参与计算布局，子节点中可能包含view
open class VirtualLayout: RenderLayout {
    public let child: Layoutable
    init(child: Layoutable) {
        self.child = child
        super.init()
    }
    public override var childs: [Layoutable] {
        return [self.child]
    }
    open override func configInit() {
        _addChild(child)
        super.configInit()
        changeFlexIfZero(1)
        if isUseYogaLayout {
            yogaLayoutConfig()
        }
    }
    open override func layoutDidChanged(oldFrame: CGRect) {
        super.layoutDidChanged(oldFrame: oldFrame)
        guard isUseYogaLayout == false else { return }
        layoutUpdate(oldFrame: oldFrame, newFrame: self.frame)
    }
    // MARK:
    public func sizeThatFits(_ size: CGSize) -> CGSize {
        return child.sizeThatFits(size)
    }
    /// 手动计算布局时实现
    func layoutUpdate(oldFrame: CGRect, newFrame: CGRect) {
        
    }
    /// 默认使用自有尺寸 如果自有尺寸小于newFrame.size 尝试重新计算一次
    func layoutSizeUpdate(_ newFrame: CGRect) -> CGSize {
        return layoutSizeUpdate(self.intrinsicSize, newFrame: newFrame)
    }
    func layoutSizeUpdate(_ oldSize: CGSize, newFrame: CGRect) -> CGSize {
        let nanSize = CGSize.nan
        var reSize = nanSize
        if oldSize.width > newFrame.size.width {
            reSize.width = newFrame.size.width
        }
        if oldSize.height > newFrame.size.height {
            reSize.height = newFrame.size.height
        }
        if reSize != nanSize {
            return calculateLayout(with: oldSize)
        } else {
            return oldSize
        }
    }
    /// 加入yoga计算布局时计算
    func yogaLayoutConfig() {
        
    }
}
extension VirtualLayout {
    var intrinsicSize: CGSize {
        return calculateLayout(with: CGSize.nan)
    }
    func calculateLayout(with size: CGSize) -> CGSize {
        return child.yoga.calculateLayout(with: size)
    }
}
extension VirtualLayout: Layoutable {
    public var isLeaf: Bool {
        // 如果是yoga布局 需要确定子节点，如果是自己手动布局相当于就是一个叶子节点
        if isUseYogaLayout {
            return _isLeaf
        } else {
            return true            
        }
    }
}
extension Layoutable {
    internal func changeFlexIfZero(_ value: CGFloat) {
        if self.yoga.flexGrow == 0 {
            self.yoga.flexGrow = value
        }
        if self.yoga.flexShrink == 0 {
            self.yoga.flexShrink = value
        }
    }
}
