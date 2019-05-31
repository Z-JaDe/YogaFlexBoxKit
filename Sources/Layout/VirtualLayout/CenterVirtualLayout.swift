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
class CenterVirtualLayout: VirtualLayout {
    let option: CenterVirtualLayoutOptions
    init(child: ChildType, option: CenterVirtualLayoutOptions, isUseYoga: Bool) {
        self.option = option
        super.init(child: child, isUseYoga: isUseYoga)
    }
    // MARK:
    override func layoutChildOrigin(_ newFrame: CGRect, _ size: CGSize) -> CGPoint {
        switch option {
        case .X:
            return CGPoint(
                x: (newFrame.size.width - size.width) / 2,
                y: 0
            )
        case .Y:
            return CGPoint(
                x: 0,
                y: (newFrame.size.height - size.height) / 2
            )
        case .XY:
            return CGPoint(
                x: (newFrame.size.width - size.width) / 2,
                y: (newFrame.size.height - size.height) / 2
            )
        }
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
