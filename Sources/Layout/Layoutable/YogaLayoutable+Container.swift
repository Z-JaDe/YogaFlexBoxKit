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
}
extension ActualLayout: YogaContainerLayoutable {
    public func addChild(_ child: YogaLayoutable) {
        _addChild(child)
        _addChildView(child)
    }
    func _addChildView(_ child: YogaLayoutable) {
        if let childView = (child as? ActualLayout)?.view {
            view?.addSubview(childView.ownerView)
        } else if let child = child as? VirtualLayout {
            _addChildView(child.child)
        } else if let child = child as? YogaLayoutable & YogaContainerLayoutable {
            child.childs.forEach({_addChildView($0)})
        }
    }
}
extension GridLayout: YogaContainerLayoutable {
    public func addChild(_ child: YogaLayoutable) {
        _addChild(child)
    }
}
extension PlaceholderLayout: YogaContainerLayoutable {
    public func addChild(_ child: YogaLayoutable) {
        _addChild(child)
    }
}
