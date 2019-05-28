//
//  Layoutable.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public protocol Layoutable: class {
    var frame: CGRect {get set}
    var yoga: LayoutNode {get}
    var childs: [Layoutable] {get}
    var superLayout: Layoutable? {get}
    var isLeaf: Bool {get}
    ///该节点是叶子节点的时候，才会调用
    func sizeThatFits(_ size: CGSize) -> CGSize
}
public extension Layoutable {
    func sizeThatFits(_ size: CGSize) -> CGSize {
        return .zero
    }
    var size: CGSize {
        return frame.size
    }
    var isLeaf: Bool {
        return _isLeaf
    }
}
extension Layoutable {
    var _isLeaf: Bool {
        /// 不包含可用子节点
        return childs.lazy.map({$0.yoga}).contains(where: {$0.isIncludedInLayout}) == false
    }
}
