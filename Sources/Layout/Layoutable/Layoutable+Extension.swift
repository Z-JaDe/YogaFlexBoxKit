//
//  YogaLayoutable+Extension.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/29.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension Layoutable where Self: YogaLayoutable & Viewable {
    public func corner(_ option: CornerLayoutOption) -> YogaLayoutable & Viewable {
        return CornerVirtualLayout(child: self, option: option)
    }
}
extension Layoutable where Self: YogaLayoutable & Viewable {
    public func center(_ option: CenterLayoutOption) -> YogaLayoutable & Viewable {
        return CenterVirtualLayout(child: self, option: option)
    }
}
extension Layoutable {
    public func container(containerSize: CGSize? = nil) -> Layoutable {
        return ContainerLayout(child: self, containerSize: containerSize)
    }
//    func setContainerSize(_ layout: Layoutable, _ containerSize: CGSize) -> Bool {
//        if let layout = layout as? VirtualLayout {
//            return setContainerSize(layout.child, containerSize - layout.edgesInset())
//        } else if let layout = layout as? ContainerLayout {
//            layout.containerSize = containerSize
//            return true
//        } else {
//            return false
//        }
//    }
}
