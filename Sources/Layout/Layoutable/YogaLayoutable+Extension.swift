//
//  YogaLayoutable+Extension.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/29.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension YogaLayoutable where Self: Layoutable {
    public func corner(_ option: CornerVirtualLayoutOption, isUseYoga: Bool = false) -> Layoutable {
        return CornerVirtualLayout(child: self, option: option, isUseYoga: isUseYoga)
    }
}
extension YogaLayoutable where Self: Layoutable {
    public func center(_ option: CenterVirtualLayoutOptions, isUseYoga: Bool = false) -> Layoutable {
        return CenterVirtualLayout(child: self, option: option, isUseYoga: isUseYoga)
    }
}
extension YogaLayoutable where Self: Layoutable {
    public func container(containerSize: CGSize? = nil) -> Layoutable {
        if setActualLayout(self, containerSize ?? .nan) {
            return self
        } else {
            return ActualLayout(view: self, containerSize: containerSize)
        }
    }
    func setActualLayout(_ layout: YogaLayoutable, _ containerSize: CGSize) -> Bool {
        if let layout = layout as? VirtualLayoutCompatible {
            return setActualLayout(layout.child, containerSize - layout.edgesInset())
        } else if let layout = layout as? ActualLayoutCompatible {
            layout.containerSize = containerSize
            return true
        } else {
            return false
        }
    }
}
