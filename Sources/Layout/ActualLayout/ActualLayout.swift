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
        let frame = converToViewHierarchy(self.frame)
        if self.superLayout == nil {
            if frame.origin != .zero {
                assertionFailure("根节点origin不为zero")
            }
        }
        if let scrollView = view as? UIScrollView {
            var finalFrame = self.containerRect
            if finalFrame.size.height.isNaN {
                finalFrame.size.height = frame.size.height
            }
            if finalFrame.size.width.isNaN {
                finalFrame.size.width = frame.size.width
            }
            scrollView.frame = finalFrame
            scrollView.contentSize = frame.size
        } else {
            view?.frame = frame
        }
    }
}
extension ActualLayout {
    public func configureLayout(_ closure: (LayoutNode) -> Void) {
        closure(yoga)
    }
    public func applyLayout(preserveOrigin: Bool = false) {
        var size = containerRect.size
        if isScroll {
            size.height = CGFloat.nan
        }
        yoga.applyLayout(preserveOrigin: preserveOrigin, size: size)
    }
    public var intrinsicÔSize: CGSize {
        return self.calculateLayout(with: CGSize.nan)
    }
    public func calculateLayout(with size: CGSize) -> CGSize {
        return self.yoga.calculateLayout(with: size)
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
