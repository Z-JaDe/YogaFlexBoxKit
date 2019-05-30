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
    init(child: Layoutable, option: CornerVirtualLayoutOption, isUseYoga: Bool) {
        self.option = option
        super.init(child: child, isUseYoga: isUseYoga)
    }
    // MARK:
//    override func layoutChildSize(_ newFrame: CGRect) -> CGSize {
//
//        switch option {
//        case .topLeft, .topRight, .bottomLeft, .bottomRight:
//            return super.layoutChildSize(newFrame)
//        case .leftFill, .rightFill:
//            let size = self.child.calculateLayout(with: CGSize(width: .nan, height: newFrame.size.height))
//            return layoutChildSize(size, newFrame: newFrame)
//        case .topFill, .bottomFill:
//            let size = self.child.calculateLayout(with: CGSize(width: newFrame.size.width, height: .nan))
//            return layoutChildSize(size, newFrame: newFrame)
//        }
//    }
    override func layoutChildOrigin(_ newFrame: CGRect, _ childSize: CGSize) -> CGPoint {
        switch option {
        case .topLeft(let top, let left):
            return CGPoint(
                x: left,
                y: top
            )
        case .topRight(let top, let right):
            return CGPoint(
                x: newFrame.size.width - right - childSize.width,
                y: top
            )
        case .bottomLeft(let bottom, let left):
            return CGPoint(
                x: left,
                y: newFrame.size.height - bottom - childSize.height
            )
        case .bottomRight(let bottom, let right):
            return CGPoint(
                x: newFrame.size.width - right - childSize.width,
                y: newFrame.size.height - bottom - childSize.height
            )
            
        case .topFill(let top, let fillOffset):
            return CGPoint(
                x: fillOffset,
                y: top
            )
        case .bottomFill(let bottom, let fillOffset):
            return CGPoint(
                x: fillOffset,
                y: newFrame.size.height - bottom - childSize.height
            )
        case .leftFill(let left, let fillOffset):
            return CGPoint(
                x: left,
                y: fillOffset
            )
        case .rightFill(let right, let fillOffset):
            return CGPoint(
                x: newFrame.size.width - right - childSize.width,
                y: fillOffset
            )
        }
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
        case .topLeft(let top, let left):
            yoga.justifyContent = .flexStart
            yoga.alignItems = .flexStart
            yoga.paddingTop = .init(top)
            yoga.paddingLeft = .init(left)
        case .topRight(let top, let right):
            yoga.flexDirection = .row
            yoga.justifyContent = .flexEnd
            yoga.alignItems = .flexStart
            yoga.paddingTop = .init(top)
            yoga.paddingRight = .init(right)
        case .bottomLeft(let bottom, let left):
            yoga.justifyContent = .flexEnd
            yoga.alignItems = .flexStart
            yoga.paddingBottom = .init(bottom)
            yoga.paddingLeft = .init(left)
        case .bottomRight(let bottom, let right):
            yoga.justifyContent = .flexEnd
            yoga.alignItems = .flexEnd
            yoga.paddingBottom = .init(bottom)
            yoga.paddingRight = .init(right)
            
        case .topFill(let top, let fillOffset):
            yoga.flexDirection = .column
            yoga.justifyContent = .flexStart
            yoga.alignItems = .stretch
            yoga.paddingHorizontal = .init(fillOffset)
            yoga.paddingTop = .init(top)
        case .bottomFill(let bottom, let fillOffset):
            yoga.flexDirection = .column
            yoga.justifyContent = .flexEnd
            yoga.alignItems = .stretch
            yoga.paddingHorizontal = .init(fillOffset)
            yoga.paddingBottom = .init(bottom)
        case .leftFill(let left, let fillOffset):
            yoga.flexDirection = .row
            yoga.justifyContent = .flexStart
            yoga.alignItems = .stretch
            yoga.paddingLeft = .init(left)
            yoga.paddingVertical = .init(fillOffset)
        case .rightFill(let right, let fillOffset):
            yoga.flexDirection = .row
            yoga.justifyContent = .flexEnd
            yoga.alignItems = .stretch
            yoga.paddingRight = .init(right)
            yoga.paddingVertical = .init(fillOffset)
        }
    }
}
