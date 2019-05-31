//
//  VirtualLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

///本身并不包含view 但是可以参与计算布局，子节点中可能包含view
class VirtualLayout: RenderLayout {
    ///计算布局时更新到_frame之前的临时存储
    var __size: CGSize = .zero
    typealias ChildType = Layoutable
    let child: ChildType
    let isUseYogaLayout: Bool
    init(child: ChildType, isUseYoga: Bool) {
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
        if self.frame.size != oldFrame.size {
            
        }
    }
    func childIntrinsicSize(_ containerSize: CGSize) -> CGSize {
        return .nan
    }
    // MARK:
    /// 手动计算布局时实现
    func layoutUpdate(oldFrame: CGRect, newFrame: CGRect) {
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
