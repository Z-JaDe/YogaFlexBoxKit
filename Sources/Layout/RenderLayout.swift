//
//  RenderLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
class RenderLayout {
    lazy var yoga: LayoutNode = LayoutNode(target: self)
    private(set) weak var superLayout: YogaLayoutable?
    private(set) var childs: [YogaLayoutable] = []
    var _frame: CGRect = .zero
    var frame: CGRect {
        get { return _frame }
        set {
            let oldValue = _frame
            _frame = newValue
            layoutDidChanged(oldFrame: oldValue)
        }
    }
    init() {
        configInit()
    }
    func configInit() {
        
    }
    func changePrivateFrame(_ frame: CGRect) {
        let oldValue = self._frame
        self._frame = frame
        _frameDidChanged(oldFrame: oldValue)
    }
    //内部设置frame时监听，只是更新view frame
    func _frameDidChanged(oldFrame: CGRect) {
        
    }
    //外部设置frame时监听，会触发child计算自己的frame
    func layoutDidChanged(oldFrame: CGRect) {
        
    }
}

extension RenderLayout {
    internal func _addChild(_ child: YogaLayoutable) {
        self.childs.append(child)
        if let layout = self as? YogaLayoutable {
            (child as? RenderLayout)?.setSuperLayout(layout)
        } else {
            assertionFailure("未知的类型")
        }
    }
    func setSuperLayout(_ layout: YogaLayoutable) {
        if let superLayout = self.superLayout {
            assertionFailure("layout已经拥有superLayout->\(superLayout)")
        }
        self.superLayout = layout
    }
}
