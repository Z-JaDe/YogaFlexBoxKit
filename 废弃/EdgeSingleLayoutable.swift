//
//  EdgeSingleLayoutable.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public protocol EdgeSingleLayoutable: SingleLayoutable {
    var edgesInset: UIEdgeInsets {get}
    func layoutChildOrigin(_ newFrame: CGRect, _ size: CGSize) -> CGPoint
}
public extension EdgeSingleLayoutable {
    func getFrame() -> CGRect {
        return child.getFrame() + edgesInset
    }
    func calculateLayout(with size: CGSize) -> CGSize {
        return child.calculateLayout(with: size - edgesInset) + edgesInset
    }
    func applyLayout(origin: CGPoint, size: CGSize) {
        let frame = CGRect(origin: origin, size: size)
        let childSize = child.intrinsicSize
        child.applyLayout(origin: layoutChildOrigin(frame, childSize), size: childSize)
    }
}
