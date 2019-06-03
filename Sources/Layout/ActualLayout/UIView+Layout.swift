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
    public var layout: YogaLayoutable & Viewable & YogaContainerLayoutable {
        var _layout = objc_getAssociatedObject(self, &kLayoutAssociatedKey) as? ViewActualLayout
        if let layout = _layout {
            return layout
        }
        _layout = ViewActualLayout(view: self)
        objc_setAssociatedObject(self, &kLayoutAssociatedKey, _layout, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return _layout!
    }
}
typealias ViewActualLayout = ActualLayout
extension UIView: Viewable {
    public var ownerView: UIView {
        return self
    }
}
