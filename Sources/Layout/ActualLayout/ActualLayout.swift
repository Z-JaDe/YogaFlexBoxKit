//
//  ActualLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

///本身包含view，可以添加多个子节点
public class ActualLayout: RenderLayout {
    typealias View = Viewable
    private weak var _view: View?
    private var _layout: View?
    var view: View? {
        return _view ?? _layout
    }
    public internal(set) var containerSize: CGSize
    public let isScroll: Bool
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
    public override func configInit() {
        super.configInit()
        if isScroll {
            self.changeFlexIfZero(1)
        }
    }
    open override func privateFrameDidChanged(oldFrame: CGRect) {
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
        return containerSize.isNaN ? view!.sizeThatFits(size) : containerSize
    }
    @discardableResult
    open override func calculateLayout(with size: CGSize) -> CGSize {
        if containerSize.isNaN {
            return yoga.calculateYogaLayout(with: size)
        } else {
            return containerSize
        }
    }
    open override func applyLayout(preserveOrigin: Bool, size: CGSize) {
        var size: CGSize = size
        if containerSize.width.isNaN && containerSize.height.isNaN {
            size = containerSize
        }
        yoga.applyLayout(preserveOrigin: preserveOrigin, size: size)
    }
}
