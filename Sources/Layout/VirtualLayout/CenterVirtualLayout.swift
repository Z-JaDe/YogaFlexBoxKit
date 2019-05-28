//
//  CenterVirtualLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/28.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public enum CenterVirtualLayoutOptions {
    case X
    case Y
    case XY
}
public class CenterVirtualLayout: VirtualLayout {
    let option: CenterVirtualLayoutOptions
    init(child: Layoutable, option: CenterVirtualLayoutOptions) {
        self.option = option
        super.init(child: child)
    }
    // MARK:
    override func layoutUpdate(oldFrame: CGRect, newFrame: CGRect) {
        super.layoutUpdate(oldFrame: oldFrame, newFrame: newFrame)
        let size = layoutSizeUpdate(newFrame)
        var frame: CGRect = CGRect(origin: .zero, size: size)
        switch option {
        case .X:
            frame.origin.x = (newFrame.size.width - size.width) / 2
            frame.origin.y = 0
        case .Y:
            frame.origin.x = 0
            frame.origin.y = (newFrame.size.height - size.height) / 2
        case .XY:
            frame.origin.x = (newFrame.size.width - size.width) / 2
            frame.origin.y = (newFrame.size.height - size.height) / 2
        }
        self.child.frame = frame
    }
    override func yogaLayoutConfig() {
        super.yogaLayoutConfig()
        switch option {
        case .X:
            yoga.justifyContent = .flexStart
            yoga.alignItems = .center
        case .Y:
            yoga.justifyContent = .center
            yoga.alignItems = .flexStart
        case .XY:
            yoga.justifyContent = .center
            yoga.alignItems = .center
        }
    }
}
extension Layoutable {
    public func center(_ option: CenterVirtualLayoutOptions) -> CenterVirtualLayout {
        return CenterVirtualLayout(child: self, option: option)
    }
}
