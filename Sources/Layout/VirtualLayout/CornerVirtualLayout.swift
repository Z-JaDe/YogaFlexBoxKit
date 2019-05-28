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
public class CornerVirtualLayout: VirtualLayout {
    let option: CornerVirtualLayoutOption
    init(child: Layoutable, option: CornerVirtualLayoutOption) {
        self.option = option
        super.init(child: child)
    }
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let result = super.sizeThatFits(size)
        return fitRealSize(result, +=)
    }
    // MARK:
    override func layoutUpdate(oldFrame: CGRect, newFrame: CGRect) {
        super.layoutUpdate(oldFrame: oldFrame, newFrame: newFrame)
        let size = layoutSizeUpdate(newFrame)
        var frame: CGRect = CGRect(origin: .zero, size: size)
        switch option {
        case .topLeft(let top, let left):
            frame.origin.x = left
            frame.origin.y = top
        case .topRight(let top, let right):
            frame.origin.x = newFrame.size.width - right - size.width
            frame.origin.y = top
        case .bottomLeft(let bottom, let left):
            frame.origin.x = left
            frame.origin.y = newFrame.size.height - bottom - size.height
        case .bottomRight(let bottom, let right):
            frame.origin.x = newFrame.size.width - right - size.width
            frame.origin.y = newFrame.size.height - bottom - size.height
            
        case .topFill(let top, let fillOffset):
            frame.origin.x = fillOffset
            frame.origin.y = top
        case .bottomFill(let bottom, let fillOffset):
            frame.origin.x = fillOffset
            frame.origin.y = newFrame.size.height - bottom - size.height
        case .leftFill(let left, let fillOffset):
            frame.origin.x = left
            frame.origin.y = fillOffset
        case .rightFill(let right, let fillOffset):
            frame.origin.x = newFrame.size.width - right - size.width
            frame.origin.y = fillOffset
        }
        self.child.frame = frame
    }
    override func layoutSizeUpdate(_ newFrame: CGRect) -> CGSize {
        let newFrame = CGRect(origin: newFrame.origin, size: fitRealSize(newFrame.size, -=))
        switch option {
        case .topLeft, .topRight, .bottomLeft, .bottomRight:
            return super.layoutSizeUpdate(newFrame)
        case .leftFill, .rightFill:
            let size = self.calculateLayout(with: CGSize(width: .nan, height: newFrame.size.height))
            return layoutSizeUpdate(size, newFrame: newFrame)
        case .topFill, .bottomFill:
            let size = self.calculateLayout(with: CGSize(width: newFrame.size.width, height: .nan))
            return layoutSizeUpdate(size, newFrame: newFrame)
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
extension CornerVirtualLayout {
    func fitRealSize(_ size: CGSize, _ operatorFunc: (inout CGFloat, CGFloat) -> Void) -> CGSize {
        var result = size
        switch option {
        case .topLeft(let top, let left):
            operatorFunc(&result.width, left)
            operatorFunc(&result.height, top)
        case .topRight(let top, let right):
            operatorFunc(&result.width, right)
            operatorFunc(&result.height, top)
        case .bottomLeft(let bottom, let left):
            operatorFunc(&result.width, left)
            operatorFunc(&result.height, bottom)
        case .bottomRight(let bottom, let right):
            operatorFunc(&result.width, right)
            operatorFunc(&result.height, bottom)
            
        case .topFill(let top, let fillOffset):
            operatorFunc(&result.width, fillOffset * 2)
            operatorFunc(&result.height, top)
        case .bottomFill(let bottom, let fillOffset):
            operatorFunc(&result.width, fillOffset * 2)
            operatorFunc(&result.height, bottom)
        case .leftFill(let left, let fillOffset):
            operatorFunc(&result.width, left)
            operatorFunc(&result.height, fillOffset * 2)
        case .rightFill(let right, let fillOffset):
            operatorFunc(&result.width, right)
            operatorFunc(&result.height, fillOffset * 2)
        }
        return result
    }
}
extension Layoutable {
    public func corner(_ option: CornerVirtualLayoutOption) -> CornerVirtualLayout {
        return CornerVirtualLayout(child: self, option: option)
    }
}
