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
