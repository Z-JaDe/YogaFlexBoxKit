//
//  ActualLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
///本身包含view，可以添加多个子节点
open class ActualLayout: RenderLayout {
    public weak var view: UIView?
    public var containerRect: CGRect
    private let isScroll: Bool
    init(view: UIView, containerRect: CGRect? = nil) {
        self.view = view
        self.containerRect = containerRect ?? view.frame
        self.isScroll = view is UIScrollView
        super.init()
    }

    open override func layoutDidChanged(oldFrame: CGRect) {
        super.layoutDidChanged(oldFrame: oldFrame)
        let frame = self.frame
        performInMainAsync {
            self.updateViewFrame(frame)
        }
    }
    func updateViewFrame(_ frame: CGRect) {
        ///放多点每次重新创建Timer实例，简单测试后发现速度反而慢了
//        throttle(&layoutViewTimer, interval: .milliseconds(100)) {
//        }
        let frame = self.converToViewHierarchy(frame)
        if self.superLayout == nil {
            if frame.origin != .zero {
                assertionFailure("根节点origin不为zero")
            }
        }
        if let scrollView = self.view as? UIScrollView {
            var finalFrame = self.containerRect
            if finalFrame.size.height.isNaN {
                finalFrame.size.height = frame.size.height
            }
            if finalFrame.size.width.isNaN {
                finalFrame.size.width = frame.size.width
            }
            if scrollView.frame != finalFrame {
                scrollView.frame = finalFrame
            }
            if scrollView.contentSize != frame.size {
                scrollView.contentSize = frame.size
            }
        } else {
            if frame.size.isNaN {
                assertionFailure("计算frame出错")
                return
            }
            if self.view?.frame != frame {
                self.view?.frame = frame
            }
        }
    }
}
extension ActualLayout {
    public func configureLayout(_ closure: (LayoutNode) -> Void) {
        closure(yoga)
    }
    public func applyLayout(preserveOrigin: Bool = false, viewDidLayout: (() -> Void)? = nil) {
        var size = containerRect.size
        if isScroll {
            size.height = CGFloat.nan
        }
        yoga.applyLayout(preserveOrigin: preserveOrigin, size: size)
        performInMainAsync {
            self.updateChildViewFrame()
            viewDidLayout?()
        }
    }
    public var intrinsicSize: CGSize {
        return self.calculateLayout(with: CGSize.nan)
    }
    public func calculateLayout(with size: CGSize) -> CGSize {
        return self.yoga.calculateLayout(with: size)
    }
}
/** 本想等计算好布局后再设置view的frame。但是yoga本身就是先计算好frame，然后统一设置一遍frame。所以这样做没意义，反而还要多写了一些兼容代码，故去除
    重新使用这个方法是想把设置frame的代码都统一一次性放到主线程里面执行
 */
extension Layoutable {
    public func updateChildViewFrame() {
        switch self {
        case let layout as ActualLayout:
            layout.updateViewFrame(layout.frame)
            layout.childs.forEach({$0.updateChildViewFrame()})
        case let layout as VirtualLayout:
            return layout.child.updateChildViewFrame()
        default: assertionFailure("未知的类型")
        }
    }
}
extension ActualLayout: Layoutable {
    public func sizeThatFits(_ size: CGSize) -> CGSize {
        return view?.sizeThatFits(size) ?? .zero
    }
    func converToViewHierarchy(_ rect: CGRect) -> CGRect {
        var frame = rect
        var superLayout = self.superLayout
        while let layout = superLayout {
            frame.origin.x += layout.frame.origin.x
            frame.origin.y += layout.frame.origin.y
            if let superView = (superLayout as? ActualLayout)?.view {
                frame = superView.convert(frame, to: view!.superview)
                break
            }
            superLayout = layout.superLayout
        }
        return frame
    }
}
extension ActualLayout {
    public func addChild(_ child: Layoutable) {
        _addChild(child)
        addChildView(child)
        view?.setNeedsLayout()
    }
    func addChildView(_ child: Layoutable) {
        if let childView = (child as? ActualLayout)?.view {
            view?.addSubview(childView)
        } else if let child = child as? VirtualLayout {
            addChildView(child.child)
        }
    }
}
