//
//  ActualLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

protocol ActualLayoutCompatible: class {
    var containerSize: CGSize {get set}
    var view: Viewable? {get}
}
extension ActualLayout: ActualLayoutCompatible {}

///本身包含view，可以添加多个子节点
class ActualLayout: RenderLayout {
    typealias View = Viewable
    private weak var _view: View?
    private var _layout: View?
    var view: View? {
        return _view ?? _layout
    }
    var containerSize: CGSize
    internal let isScroll: Bool
    init(view: View, containerSize: CGSize?) {
        if view is UIView {
            self._view = view
        } else {
            self._layout = view
        }
        self.containerSize = containerSize ?? .nan
        self.isScroll = view is UIScrollView
        super.init()
    }
    override func configInit() {
        super.configInit()
        if isScroll {
            self.changeFlexIfZero(1)
        }
    }
    /**
     ActualLayout如果是_frame的更新只需要更新下self.view的frame
     若是frame的更新，需要重新applyLayout下，applyLayout后会自动调用_frame更新
     ActualLayout有可能是有child的，而且self.view也有可能不是UIView
     所以_frameDidChanged变化时只更新self.view的frame
     layoutDidChanged变化时需要用yoga计算所有的childs
     */
    override func _frameDidChanged(oldFrame: CGRect) {
        super._frameDidChanged(oldFrame: oldFrame)
        performInMainAsyncIfNeed {
            self.updateViewFrame(self.frame)
        }
    }
    override func layoutDidChanged(oldFrame: CGRect) {
        super.layoutDidChanged(oldFrame: oldFrame)
        guard oldFrame != self.frame else { return }
        let frame = self.frame
        ///该方法走完会走下_frameDidChanged
        self.applyLayout(preserveOrigin: true, size: frame.size)
    }
    func performInMainAsyncIfNeed(_ action: @escaping () -> Void) {
        if view is UIView {
            performInMainAsync(action)
        } else {
            action()
        }
    }
}
