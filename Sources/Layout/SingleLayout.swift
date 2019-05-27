//
//  SingleLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

open class SingleLayout: RenderLayout, Layoutable {
    public let child: Layoutable
    init(child: Layoutable) {
        self.child = child
        super.init()
        if let child = child as? RenderLayout {
            child.superLayout = self
        }
    }
    open var childs: [Layoutable] {
        return [self.child]
    }
    public func sizeThatFits(_ size: CGSize) -> CGSize {
        return child.sizeThatFits(size)
    }
}
extension Layoutable {
    private func changeFlexIfZero(_ value: CGFloat) {
        if self.yoga.flexGrow == 0 {
            self.yoga.flexGrow = value
        }
        if self.yoga.flexShrink == 0 {
            self.yoga.flexShrink = value
        }
    }
}
// MARK - Center
public enum CenteringLayoutOptions {
    case X
    case Y
    case XY
}
extension Layoutable {
    public func center(_ centeringOptions: CenteringLayoutOptions) -> SingleLayout {
        let layout = SingleLayout(child: self)
        layout.changeFlexIfZero(1)
        switch centeringOptions {
        case .X:
            layout.yoga.justifyContent = .flexStart
            layout.yoga.alignItems = .center
        case .Y:
            layout.yoga.justifyContent = .center
            layout.yoga.alignItems = .flexStart
        case .XY:
            layout.yoga.justifyContent = .center
            layout.yoga.alignItems = .center
        }
        return layout
    }
}
// MARK: -
public enum CornerLayoutOptions {
    case topLeft(CGFloat, CGFloat)
    case topRight(CGFloat, CGFloat)
    case bottomLeft(CGFloat, CGFloat)
    case bottomRight(CGFloat, CGFloat)
    
    case topFill(CGFloat, CGFloat)
    case bottomFill(CGFloat, CGFloat)
    case leftFill(CGFloat, CGFloat)
    case rightFill(CGFloat, CGFloat)
}
extension Layoutable {
    public func corner(_ cornerOptions: CornerLayoutOptions) -> SingleLayout {
        let layout = SingleLayout(child: self)
        layout.changeFlexIfZero(1)
        switch cornerOptions {
        case .topLeft(let top, let left):
            layout.yoga.justifyContent = .flexStart
            layout.yoga.alignItems = .flexStart
            layout.yoga.paddingTop = .init(top)
            layout.yoga.paddingLeft = .init(left)
        case .topRight(let top, let right):
            layout.yoga.flexDirection = .row
            layout.yoga.justifyContent = .flexEnd
            layout.yoga.alignItems = .flexStart
            layout.yoga.paddingTop = .init(top)
            layout.yoga.paddingRight = .init(right)
        case .bottomLeft(let bottom, let left):
            layout.yoga.justifyContent = .flexEnd
            layout.yoga.alignItems = .flexStart
            layout.yoga.paddingBottom = .init(bottom)
            layout.yoga.paddingLeft = .init(left)
        case .bottomRight(let bottom, let right):
            layout.yoga.justifyContent = .flexEnd
            layout.yoga.alignItems = .flexEnd
            layout.yoga.paddingBottom = .init(bottom)
            layout.yoga.paddingRight = .init(right)
            
        case .topFill(let offSet, let fillOffset):
            self.changeFlexIfZero(1)
            layout.yoga.flexDirection = .row
            layout.yoga.justifyContent = .flexStart
            layout.yoga.alignItems = .flexStart
            layout.yoga.paddingHorizontal = .init(fillOffset)
            layout.yoga.paddingTop = .init(offSet)
        case .bottomFill(let offSet, let fillOffset):
            self.changeFlexIfZero(1)
            layout.yoga.flexDirection = .row
            layout.yoga.justifyContent = .flexStart
            layout.yoga.alignItems = .flexEnd
            layout.yoga.paddingHorizontal = .init(fillOffset)
            layout.yoga.paddingBottom = .init(offSet)
        case .leftFill(let offSet, let fillOffset):
            self.changeFlexIfZero(1)
            layout.yoga.flexDirection = .column
            layout.yoga.justifyContent = .flexStart
            layout.yoga.alignItems = .flexStart
            layout.yoga.paddingLeft = .init(offSet)
            layout.yoga.paddingVertical = .init(fillOffset)
        case .rightFill(let offSet, let fillOffset):
            self.changeFlexIfZero(1)
            layout.yoga.flexDirection = .column
            layout.yoga.justifyContent = .flexStart
            layout.yoga.alignItems = .flexEnd
            layout.yoga.paddingRight = .init(offSet)
            layout.yoga.paddingVertical = .init(fillOffset)
        }
        return layout
    }
}
