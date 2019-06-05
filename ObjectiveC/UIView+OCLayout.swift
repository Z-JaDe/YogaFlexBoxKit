//
//  UIView.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/5.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension UIView {
    @objc
    public var yoga: LayoutNode {
        return self.layout.yoga
    }
    @objc
    public func configureLayout(_ closure: (_ yoga: LayoutNode) -> Void) {
        closure(yoga)
    }
    @objc
    public func calculateLayout(with size: CGSize) -> CGSize {
        return self.layout.calculateLayout(with: size)
    }
    ///更新布局
    @objc
    public func applyLayout(origin: CGPoint, size: CGSize) {
        self.applyLayout(origin: origin, size: size)
    }
    @objc
    public func applyLayout(origin: CGPoint, size: CGSize, containerSize: CGSize) {
        return ContainerLayout(child: self.layout, containerSize: containerSize).applyLayout(origin: origin, size: size)
    }
}
extension UIView {
    @objc
    public func addChildLayout(_ child: AnyObject) {
        switch child {
        case let child as UIView:
            self.layout.addChild(child.layout)
        case let child as YogaLayoutable:
            self.layout.addChild(child)
        default:
            assertionFailure("未知的类型")
        }
    }
    @objc
    public func removeChildLayout(_ child: AnyObject) {
        switch child {
        case let child as UIView:
            self.layout.removeChild(child.layout)
        case let child as YogaLayoutable:
            self.layout.removeChild(child)
        default:
            assertionFailure("未知的类型")
        }
    }
    @objc
    public func removeAllChildLayout() {
        self.layout.removeAllChild()
    }
}
