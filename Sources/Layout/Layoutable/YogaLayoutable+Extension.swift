//
//  YogaLayoutable+Extension.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/29.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension YogaLayoutable where Self: Layoutable {
    public func corner(_ option: CornerVirtualLayoutOption) -> Layoutable {
        return CornerVirtualLayout(child: self, option: option)
    }
}
extension YogaLayoutable where Self: Layoutable {
    public func center(_ option: CenterVirtualLayoutOptions, isUseYoga: Bool = false) -> Layoutable {
        return CenterVirtualLayout(child: self, option: option)
    }
}
extension YogaLayoutable where Self: Layoutable {
    public func container(containerSize: CGSize? = nil) -> Layoutable {
        let containerSize = containerSize ?? .nan
        if setContainerSize(self, containerSize) {
            return self
        } else {
            return ActualLayout(view: self, containerSize: containerSize)
        }
    }
    func setContainerSize(_ layout: YogaLayoutable, _ containerSize: CGSize) -> Bool {
        if let layout = layout as? VirtualLayout {
            return setContainerSize(layout.child, containerSize - layout.edgesInset())
        } else if let layout = layout as? ActualLayout {
            layout.containerSize = containerSize
            return true
        } else {
            return false
        }
    }
}
