//
//  UIView+Layout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/22.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
private var kLayoutAssociatedKey: UInt8 = 0

extension UIView {
    private var layout: ViewActualLayout {
        var _layout = objc_getAssociatedObject(self, &kLayoutAssociatedKey) as? ViewActualLayout
        if let layout = _layout {
            return layout
        }
        _layout = ViewActualLayout(view: self)
        objc_setAssociatedObject(self, &kLayoutAssociatedKey, _layout, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return _layout!
    }
}
private typealias ViewActualLayout = ActualLayout

extension UIView: YogaLayoutable {
    public func calculate(size: CGSize) -> CGSize {
        return layout.calculate(size: size)
    }
    public func applyLayout(origin: CGPoint, size: CGSize) {
        layout.applyLayout(origin: origin, size: size)
    }
    public func calculateLayout(with size: CGSize) -> CGSize {
        return layout.calculateLayout(with: size)
    }
    public var yoga: LayoutNode {
        return layout.yoga
    }
    public var childs: [YogaLayoutable] {
        return layout.childs
    }
    public var superLayout: YogaLayoutable? {
        return layout.superLayout
    }
    public func changePrivateFrame(_ frame: CGRect) {
        layout.changePrivateFrame(frame)
    }
}
extension UIView: YogaContainerLayoutable {
    public func addChild(_ child: YogaLayoutable) {
        layout.addChild(child)
    }
    public func removeChild(_ child: YogaLayoutable) {
        layout.removeChild(child)
    }
    public func removeAllChild() {
        layout.removeAllChild()
    }
    public func removeFromSuperLayout() {
        layout.removeFromSuperLayout()
    }
    
    internal func _setSuperLayout(_ layout: YogaLayoutable?) {
        self.layout._setSuperLayout(layout)
    }
}
