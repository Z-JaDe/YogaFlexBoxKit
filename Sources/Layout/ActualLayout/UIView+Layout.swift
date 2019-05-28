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
    public var layout: ActualLayout {
        var layout = objc_getAssociatedObject(self, &kLayoutAssociatedKey) as? ActualLayout
        if let layout = layout {
            return layout
        }
        layout = ActualLayout(view: self)
        objc_setAssociatedObject(self, &kLayoutAssociatedKey, layout, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return layout!
    }
}
