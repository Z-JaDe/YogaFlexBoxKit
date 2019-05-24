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
    public var layout: WrapLayout {
        var layout = objc_getAssociatedObject(self, &kLayoutAssociatedKey) as? WrapLayout
        if let layout = layout {
            return layout
        }
        layout = WrapLayout(view: self)
        objc_setAssociatedObject(self, &kLayoutAssociatedKey, layout, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return layout!
    }
}
//public class ViewLayoutNode: LayoutNode {
//    @available(*, unavailable, message: "使用view")
//    public override var layoutable: Layoutable! {
//        return super.layoutable
//    }
//    public var view: UIView! {
//        return super.layoutable as? UIView
//    }
//    init(view: UIView) {
//        super.init(target: view)
//    }
//}
