//
//  LeafLayout.swift
//  YogaFlexBoxKit
//
//  Created by Z_JaDe on 2019/6/1.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
///该协议声明了一个叶子节点，需要实现的方法，LeafLayout子类实现该协议可以快速实现一个叶子节点
public protocol LeafLayoutProtocol {
    func calculateSize(_ size: CGSize) -> CGSize
    func frameDidChanged(oldFrame: CGRect, newFrame: CGRect)
}
open class LeafLayout: RenderLayout {
    public private(set) var isLoad: Bool = false
    open override func configInit() {
        super.configInit()
        changeFlexIfZero(1)
    }
    public override final var isLeaf: Bool {
        return true
    }
    public override final func privateFrameDidChanged(oldFrame: CGRect) {
        guard oldFrame != self.frame else { return }
        (self as? LeafLayoutProtocol)?.frameDidChanged(oldFrame: oldFrame, newFrame: self.frame)
        self.isLoad = true
    }
    public override final func sizeThatFits(_ size: CGSize) -> CGSize {
        return (self as? LeafLayoutProtocol)?.calculateSize(size) ?? .zero
    }
}
extension LeafLayout {
    public func makeDirty() {
        guard self.yoga.isDirty == false else {
            return
        }
        self.yoga.markDirty()
    }
}
