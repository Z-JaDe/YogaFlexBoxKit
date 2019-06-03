//
//  YogaLayoutable+Container.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/30.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public protocol YogaContainerLayoutable {
    func addChild(_ child: YogaLayoutable)
    func removeChild(_ child: YogaLayoutable)
    func removeAllChild()
    func removeFromSuperLayout()
}
extension YogaLayoutable {
    func findFirstSuperActualLayout() -> ActualLayout? {
        if let layout = self as? ActualLayout {
            return layout
        }
        return self.superLayout?.findFirstSuperActualLayout()
    }
}
extension YogaContainerLayoutable where Self: YogaLayoutable {
    func _addChildView(_ child: YogaLayoutable) {
        guard let view = self.findFirstSuperActualLayout() else {
            assertionFailure("layout需要先添加到ActualLayout里面再addChid")
            return
        }
        _addChildView(child, in: view.ownerView)
    }
    func _addChildView(_ child: YogaLayoutable, in view: UIView) {
        if let child = (child as? ActualLayout) {
            if let childView = child.view {
                view.addSubview(childView.ownerView)
            }
        } else if let child = child as? VirtualLayout {
            _addChildView(child.child, in: view)
        } else if let child = child as? YogaLayoutable & YogaContainerLayoutable {
            child.childs.forEach({_addChildView($0, in: view)})
        }
    }
    func _removeChildView(_ child: YogaLayoutable) {
        if let childView = (child as? ActualLayout)?.view {
            childView.ownerView.removeFromSuperview()
        } else if let child = child as? VirtualLayout {
            _removeChildView(child.child)
        } else if let child = child as? YogaLayoutable & YogaContainerLayoutable {
            child.childs.forEach({_removeChildView($0)})
        }
    }
}
extension YogaContainerLayoutable where Self: RenderLayout {
    public func addChild(_ child: YogaLayoutable) {
        _addChild(child)
        _addChildView(child)
        makeDirtyIfNeed()
    }
    public func removeChild(_ child: YogaLayoutable) {
        _removeChildView(child)
        _removeChild(child)
        makeDirtyIfNeed()
    }
    public func removeAllChild() {
        self.childs.forEach({_removeChildView($0)})
        _removeAllChild()
        makeDirtyIfNeed()
    }
    public func removeFromSuperLayout() {
        guard let superlayout = self.superLayout as? YogaContainerLayoutable else {
            return
        }
        superlayout.removeChild(self)
    }
    fileprivate func makeDirtyIfNeed() {
        if self.isLeaf && self.yoga.isDirty == false && YGNodeHasMeasureFunc(self.yoga.yogaNode) {
            self.yoga.markDirty()
        }
    }
}
extension ActualLayout: YogaContainerLayoutable {}
extension GridLayout: YogaContainerLayoutable {}
extension StackLayout: YogaContainerLayoutable {}
extension PlaceholderLayout: YogaContainerLayoutable {
    public func addChild(_ child: YogaLayoutable) {
        _addChild(child)
        makeDirtyIfNeed()
    }
    public func removeChild(_ child: YogaLayoutable) {
        _removeChild(child)
        makeDirtyIfNeed()
    }
    public func removeAllChild() {
        _removeAllChild()
        makeDirtyIfNeed()
    }
}

extension YogaLayoutable where Self: YogaContainerLayoutable {
    func hasExactSameChildren<C: Collection>(_ childs: C) -> Bool where C.Element == YogaLayoutable {
        let _childs = self.childs.lazy.filter({$0.yoga.isIncludedInLayout})
        if _childs.count != childs.count {
            return false
        }
        return childs.enumerated().allSatisfy({$0.element === _childs[$0.offset]})
    }
}
