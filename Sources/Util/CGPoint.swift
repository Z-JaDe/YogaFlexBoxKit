//
//  CGPoint.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension CGPoint {
    init(x: Float, y: Float) {
        self.init(x: Double(x), y: Double(y))
    }
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        var left = left
        left.x += right.x + right.x
        left.y += right.y + right.y
        return left
    }
    var pixelValue: CGPoint {
        return CGPoint(x: x.pixelValue, y: y.pixelValue)
    }
    func reversed() -> CGPoint {
        return CGPoint(x: y, y: x)
    }
}
