//
//  LayoutNode.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/22.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public class LayoutNode: AbstractLayoutNode {
    @available(*, unavailable, message: "使用layoutable")
    public override var target: AnyObject? {
        return super.target
    }
    var layoutable: Layoutable! {
        return super.target as? Layoutable
    }
    @available(*, unavailable, message: "内部使用")
    public override var node: YGNodeRef {
        return super.node
    }
    var yogaNode: YGNodeRef {
        return super.node
    }
    public var isIncludedInLayout: Bool = true
    
    open var isLeaf: Bool {
        return layoutable?.isLeaf ?? true
    }
    
    public override func markDirty() {
        guard isLeaf else { return }
        guard self.isDirty == false else { return }
        /**
         不知道为什么判断有measure函数的时候，再设置一次measure函数。
         通过代码看，应该是measure函数有2种：一种有上下文 一种没有上下文。
         yoga只公开了没有上下文的measure函数，这里判断当之前设置过没有上下文的measure函数，就可以继续设置
         有上下文的度量函数不知道哪里用到了，有可能是保留参数
         */
        if YGNodeHasMeasureFunc(yogaNode) {
            self.setMeasureFunc(measureView)
        }
        super.markDirty()
    }
}
