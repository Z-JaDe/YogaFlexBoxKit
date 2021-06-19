//
//  ActualLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

/// 本身包含view，可以添加多个子节点
class ActualLayout: RenderLayout {
    typealias View = UIView
    private weak var _view: View?
    var view: View? {
        return _view
    }
    let isScroll: Bool
    init(view: View) {
        self.isScroll = view is UIScrollView
        super.init()
        self._view = view
    }
    override func configInit() {
        super.configInit()
        if isScroll {
            self.changeFlexIfZero(1)
        }
    }
    override func privateFrameDidChanged(oldFrame: CGRect) {
        super.privateFrameDidChanged(oldFrame: oldFrame)
        performInMainAsync {
            self.updateViewFrame(self.getFrame())
        }
    }
    open override func calculate(size: CGSize) -> CGSize {
        return view?.sizeThatFits(size) ?? .zero
    }
}
