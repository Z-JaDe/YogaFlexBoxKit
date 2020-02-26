//
//  Layoutable.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public protocol YogaLayoutable: class, Layoutable {
    var yoga: LayoutNode {get}
    var childs: [YogaLayoutable] {get}
    var superLayout: YogaLayoutable? {get}
    var isLeaf: Bool {get}
    func changeFrame(_ newValue: CGRect)
    ///该节点是叶子节点的时候，才会调用，适配尺寸
    func calculate(size: CGSize) -> CGSize
    ///内部计算好frame会调用该方法，实现协议需要实现该方法 更新内部布局
    func changePrivateFrame(_ newValue: CGRect)
}
public extension YogaLayoutable {
    func configureLayout(_ closure: (LayoutNode) -> Void) {
        closure(yoga)
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
extension YogaLayoutable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.yoga == rhs.yoga
    }
}
internal extension YogaLayoutable {
    var _isLeaf: Bool {
        /// 不包含可用子节点
        return childs.lazy.map({$0.yoga}).contains(where: {$0.isIncludedInLayout}) == false
    }
}
