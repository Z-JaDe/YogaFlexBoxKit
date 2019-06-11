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
    public var yogaNode: LayoutNode {
        return self.yoga
    }
    @objc
    public func configureLayout(_ closure: (_ yoga: LayoutNode) -> Void) {
        closure(yogaNode)
    }

    @objc
    public func applyLayout(origin: CGPoint, size: CGSize, containerSize: CGSize) {
        return ContainerLayout(child: self, containerSize: containerSize).applyLayout(origin: origin, size: size)
    }
}
extension UIView {
    @objc
    public func addChildLayout(_ child: AnyObject) {
        _addChildLayout(child)
    }
    @objc
    public func removeChildLayout(_ child: AnyObject) {
        _removeChildLayout(child)
    }
    @objc
    public func removeAllChildLayout() {
        _removeAllChildLayout()
    }
}
extension StackLayout {
    @objc
    public func addChildLayout(_ child: AnyObject) {
        _addChildLayout(child)
    }
    @objc
    public func removeChildLayout(_ child: AnyObject) {
        _removeChildLayout(child)
    }
    @objc
    public func removeAllChildLayout() {
        _removeAllChildLayout()
    }
}
extension GridLayout {
    @objc
    public func addChildLayout(_ child: AnyObject) {
        _addChildLayout(child)
    }
    @objc
    public func removeChildLayout(_ child: AnyObject) {
        _removeChildLayout(child)
    }
    @objc
    public func removeAllChildLayout() {
        _removeAllChildLayout()
    }
}
fileprivate extension YogaContainerLayoutable {
    func _addChildLayout(_ child: AnyObject) {
        switch child {
        case let child as YogaLayoutable:
            self.addChild(child)
        default:
            assertionFailure("未知的类型")
        }
    }
    func _removeChildLayout(_ child: AnyObject) {
        switch child {
        case let child as YogaLayoutable:
            self.removeChild(child)
        default:
            assertionFailure("未知的类型")
        }
    }
    func _removeAllChildLayout() {
        self.removeAllChild()
    }
}
