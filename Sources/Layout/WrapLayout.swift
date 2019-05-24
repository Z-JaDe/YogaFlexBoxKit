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
    init(view: UIView) {
        self.view = view
    }
    public private(set) var childs: [Layoutable] = []

    open override func layoutChanged() {
        super.layoutChanged()
        var frame = converToViewHierarchy(self.frame)
        if self.superLayout == nil {
            if frame.origin != .zero {
                assertionFailure("根节点origin不为zero")
                frame.origin = .zero
            }
        }
        if let scrollView = view as? UIScrollView {
            scrollView.frame.origin = frame.origin
            scrollView.contentSize = frame.size
        } else {
            view?.frame = frame
        }
    }
}
extension WrapLayout {
    public func configureLayout(_ closure: (LayoutNode) -> Void) {
        closure(self.yoga)
    }
    public func applyLayout(preserveOrigin: Bool = false) {
        self.yoga.applyLayout(preserveOrigin: preserveOrigin)
    }
    public func applyLayout(preserveOrigin: Bool = false, dimensionFlexibility: YGDimensionFlexibility) {
        self.yoga.applyLayout(preserveOrigin: preserveOrigin, dimensionFlexibility: dimensionFlexibility)
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
