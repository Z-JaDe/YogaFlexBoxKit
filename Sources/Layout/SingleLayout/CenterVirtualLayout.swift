//
//  CenterVirtualLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/28.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
import yoga
public enum CenterLayoutOption {
    case X
    case Y
    case XY
}
class CenterVirtualLayout: VirtualLayout {
    let option: CenterLayoutOption
    init(child: ChildType, option: CenterLayoutOption) {
        self.option = option
        super.init(child: child)
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
