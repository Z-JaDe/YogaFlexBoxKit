//
//  CornerVirtualswift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/28.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public enum CornerVirtualLayoutOption {
    case topLeft(CGFloat, CGFloat)
    case topRight(CGFloat, CGFloat)
    case bottomLeft(CGFloat, CGFloat)
    case bottomRight(CGFloat, CGFloat)
    
    case topFill(CGFloat, CGFloat)
    case bottomFill(CGFloat, CGFloat)
    case leftFill(CGFloat, CGFloat)
    case rightFill(CGFloat, CGFloat)
}
class CornerVirtualLayout: VirtualLayout {
    let option: CornerVirtualLayoutOption
    init(child: ChildType, option: CornerVirtualLayoutOption) {
        self.option = option
        super.init(child: child)
    }
    override func edgesInset() -> UIEdgeInsets {
        switch option {
        case .topLeft(let top, let left):
            return UIEdgeInsets(top: top, left: left, bottom: 0, right: 0)
        case .topRight(let top, let right):
            return UIEdgeInsets(top: top, left: 0, bottom: 0, right: right)
        case .bottomLeft(let bottom, let left):
            return UIEdgeInsets(top: 0, left: left, bottom: bottom, right: 0)
        case .bottomRight(let bottom, let right):
            return UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: right)
            
        case .topFill(let top, let fillOffset):
            return UIEdgeInsets(top: top, left: fillOffset, bottom: 0, right: fillOffset)
        case .bottomFill(let bottom, let fillOffset):
            return UIEdgeInsets(top: 0, left: fillOffset, bottom: bottom, right: fillOffset)
        case .leftFill(let left, let fillOffset):
            return UIEdgeInsets(top: fillOffset, left: left, bottom: fillOffset, right: 0)
        case .rightFill(let right, let fillOffset):
            return UIEdgeInsets(top: fillOffset, left: 0, bottom: fillOffset, right: right)
        }
    }
    override func yogaLayoutConfig() {
        super.yogaLayoutConfig()
        switch option {
        case .topLeft:
            yoga.justifyContent = .flexStart
            yoga.alignItems = .flexStart
        case .topRight:
            yoga.flexDirection = .row
            yoga.justifyContent = .flexEnd
            yoga.alignItems = .flexStart
        case .bottomLeft:
            yoga.justifyContent = .flexEnd
            yoga.alignItems = .flexStart
        case .bottomRight:
            yoga.justifyContent = .flexEnd
            yoga.alignItems = .flexEnd
            
        case .topFill:
            yoga.flexDirection = .column
            yoga.justifyContent = .flexStart
            yoga.alignItems = .stretch
        case .bottomFill:
            yoga.flexDirection = .column
            yoga.justifyContent = .flexEnd
            yoga.alignItems = .stretch
        case .leftFill:
            yoga.flexDirection = .row
            yoga.justifyContent = .flexStart
            yoga.alignItems = .stretch
        case .rightFill:
            yoga.flexDirection = .row
            yoga.justifyContent = .flexEnd
            yoga.alignItems = .stretch
        }
        let edge = edgesInset()
        if edge.left > 0 {
            yoga.paddingLeft = .init(edge.left)
        }
        if edge.right > 0 {
            yoga.paddingRight = .init(edge.right)
        }
        if edge.top > 0 {
            yoga.paddingTop = .init(edge.top)
        }
        if edge.bottom > 0 {
            yoga.paddingBottom = .init(edge.bottom)
        }
    }
}
