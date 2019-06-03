//
//  VirtualLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

///本身并不包含view 但是可以参与计算布局，子节点中可能包含view
public class VirtualLayout: RenderLayout {
    public typealias ChildType = Layoutable & Viewable
    public let child: ChildType
    init(child: ChildType) {
        self.child = child
        super.init()
    }
    public override func configInit() {
        _addChild(child)
        super.configInit()
        changeFlexIfZero(1)
        yogaLayoutConfig()
    }
    /// 加入yoga计算布局时计算
    func yogaLayoutConfig() {
        
    }
    /// child内缩
    func edgesInset() -> UIEdgeInsets {
        return .zero
    }
    open override var isLeaf: Bool {
        return false
    }
}
