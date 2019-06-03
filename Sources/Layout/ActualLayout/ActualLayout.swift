//
//  ActualLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

///本身包含view，可以添加多个子节点
class ActualLayout: RenderLayout {
    typealias View = Viewable
    private weak var _view: View?
    private var _layout: View?
    var view: View? {
        return _view ?? _layout
    }
    let isScroll: Bool
    init(view: View) {
        self.isScroll = view is UIScrollView
        super.init()
        if view is UIView {
            self._view = view
        } else {
            self._layout = view
        }
    }
    override func configInit() {
        super.configInit()
        if isScroll {
            self.changeFlexIfZero(1)
        }
    }
    override func privateFrameDidChanged(oldFrame: CGRect) {
        super.privateFrameDidChanged(oldFrame: oldFrame)
        performInMainAsyncIfNeed {
            self.updateViewFrame(self.frame)
        }
    }
    func performInMainAsyncIfNeed(_ action: @escaping () -> Void) {
        if view is UIView {
            performInMainAsync(action)
        } else {
            action()
        }
    }
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return view?.sizeThatFits(size) ?? .zero
    }
}
