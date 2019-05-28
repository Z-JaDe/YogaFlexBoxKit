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
}
