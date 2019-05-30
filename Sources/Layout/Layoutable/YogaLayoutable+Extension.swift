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
        let containerSize = containerSize ?? .nan
        if setActualLayout(self, containerSize) {
            return self
        } else {
            let layout = ActualLayout(view: self)
            layout.containerSize = containerSize
            return layout
        }
    }
    func setActualLayout(_ layout: YogaLayoutable, _ containerSize: CGSize) -> Bool {
        if let layout = layout as? VirtualLayoutCompatible {
            layout.containerSize = containerSize
            return true
        } else if let layout = layout as? ActualLayoutCompatible {
            layout.containerSize = containerSize
            return true
        } else {
            return false
        }
    }
}
