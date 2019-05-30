//
//  VirtualLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
// MARK: -
protocol VirtualLayoutCompatible {
    var child: Layoutable {get}
    func edgesInset() -> UIEdgeInsets
}
extension VirtualLayout: VirtualLayoutCompatible {}

///本身并不包含view 但是可以参与计算布局，子节点中可能包含view
class VirtualLayout: RenderLayout {
    let child: Layoutable
    let isUseYogaLayout: Bool
    init(child: Layoutable, isUseYoga: Bool) {
        self.child = child
        self.isUseYogaLayout = isUseYoga
        super.init()
    }
    override func configInit() {
        _addChild(child)
        super.configInit()
        changeFlexIfZero(1)
        if isUseYogaLayout {
            yogaLayoutConfig()
        }
    }
    /**
     VirtualLayout不管是主动设置的frame还是内部设置的_frame。
     因为手动布局时VirtualLayout在yoga中没有childs，所以每次更新frame后 都要重新计算child的frame且VirtualLayout本身并不需要更新。
     VirtualLayout本身并不需要更新UIView的frame
     所以layoutDidChanged和_frameDidChanged的代码是一致的
     */
    override func layoutDidChanged(oldFrame: CGRect) {
        super.layoutDidChanged(oldFrame: oldFrame)
        layout(oldFrame: oldFrame)
    }
    override func _frameDidChanged(oldFrame: CGRect) {
        super._frameDidChanged(oldFrame: oldFrame)
        layout(oldFrame: oldFrame)
    }
    func layout(oldFrame: CGRect) {
        guard isUseYogaLayout == false else { return }
        guard oldFrame != self.frame else {
            ///如果重复设置frame，只更新下self.view的frame即可，故调用_frameDidChanged
//            (self.child as? RenderLayout)?.changePrivateFrame(self.child.frame)
            return
        }
        self.layoutUpdate(oldFrame: oldFrame, newFrame: self.frame)
    }
    // MARK:
    /// 手动计算布局时实现
    func layoutUpdate(oldFrame: CGRect, newFrame: CGRect) {
        let size = layoutChildSize(newFrame)
        self.child.frame = CGRect(origin: layoutChildOrigin(newFrame, size), size: size)
    }
    /// 默认使用自有尺寸 如果自有尺寸小于newFrame.size 尝试重新计算一次
    func layoutChildSize(_ newFrame: CGRect) -> CGSize {
        return layoutChildSize(self.child.intrinsicSize, newFrame: newFrame)
    }
    ///计算位置
    func layoutChildOrigin(_ newFrame: CGRect, _ size: CGSize) -> CGPoint {
        return .zero
    }
    /// child内缩
    func edgesInset() -> UIEdgeInsets {
        return .zero
    }

    /// 加入yoga计算布局时计算
    func yogaLayoutConfig() {
        
    }
}
