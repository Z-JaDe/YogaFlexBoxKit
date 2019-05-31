//
//  Layoutable.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public typealias Layoutable = YogaLayoutable & YogaCalculateLayoutable
public protocol YogaLayoutable: class {
    var frame: CGRect {get}
    var yoga: LayoutNode {get}
    var childs: [YogaLayoutable] {get}
    var superLayout: YogaLayoutable? {get}
    var isLeaf: Bool {get}
    ///该节点是叶子节点的时候，才会调用
    func sizeThatFits(_ size: CGSize) -> CGSize
}
public extension YogaLayoutable {
    func configureLayout(_ closure: (LayoutNode) -> Void) {
        closure(yoga)
    }
    var isLeaf: Bool {
        return _isLeaf
    }
    func changeFlexIfZero(_ value: CGFloat) {
        if self.yoga.flexGrow == 0 {
            self.yoga.flexGrow = value
        }
        if self.yoga.flexShrink == 0 {
            self.yoga.flexShrink = value
        }
    }
}
internal extension YogaLayoutable {
    var _isLeaf: Bool {
        /// 不包含可用子节点
        return childs.lazy.map({$0.yoga}).contains(where: {$0.isIncludedInLayout}) == false
    }
}

