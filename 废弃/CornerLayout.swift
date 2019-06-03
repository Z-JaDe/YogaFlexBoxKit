//
//  CornerLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

struct CornerLayout {
    let child: Layoutable
    let option: CornerLayoutOption
    let edgesInset: UIEdgeInsets
    init(child: Layoutable, option: CornerLayoutOption) {
        self.child = child
        self.option = option
        self.edgesInset = {
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
        }()
    }
}
extension CornerLayout: EdgeSingleLayoutable {
    func layoutChildOrigin(_ newFrame: CGRect, _ childSize: CGSize) -> CGPoint {
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
}
