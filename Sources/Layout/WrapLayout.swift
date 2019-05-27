//
//  WrapLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

open class WrapLayout: RenderLayout {
    public weak var view: UIView?
    public var containerRect: CGRect
    init(view: UIView, containerRect: CGRect? = nil) {
        self.view = view
        self.containerRect = containerRect ?? view.frame
        super.init()
    }
    public private(set) var childs: [Layoutable] = []

    open override func layoutChanged() {
        super.layoutChanged()
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
    var isScroll: Bool {
        return view is UIScrollView
    }
}
extension WrapLayout {
    public func configureLayout(_ closure: (LayoutNode) -> Void) {
        closure(self.yoga)
    }
    public func applyLayout(preserveOrigin: Bool = false) {
        var size = containerRect.size
        if isScroll {
            size.height = CGFloat.nan
        }
        self.yoga.applyLayout(preserveOrigin: preserveOrigin, size: size)
    }
    public var intrinsicSize: CGSize {
        return self.yoga.intrinsicSize
    }
    @discardableResult
    public func calculateLayout(with size: CGSize) -> CGSize {
        return self.yoga.calculateLayout(with: size)
    }
}
extension WrapLayout: Layoutable {
    public func sizeThatFits(_ size: CGSize) -> CGSize {
        return view!.sizeThatFits(size)
    }
    func converToViewHierarchy(_ rect: CGRect) -> CGRect {
        var frame = rect
        var superLayout = self.superLayout
        while let layout = superLayout {
            frame.origin.x += layout.frame.origin.x
            frame.origin.y += layout.frame.origin.y
            if let superView = (superLayout as? WrapLayout)?.view {
                frame = superView.convert(frame, to: view!.superview)
                break
            }
            superLayout = layout.superLayout
        }
        return frame
    }
}
extension WrapLayout {
    public func addChild(_ child: Layoutable) {
        self.childs.append(child)
        if let child = child as? RenderLayout {
            child.superLayout = self
        }
        view?.setNeedsLayout()
    }
}
