//
//  CGRect.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
/*
 extension UIEdgeInsets {
     init(top: Float, left: Float, bottom: Float, right: Float) {
         self.init(top: CGFloat(top), left: CGFloat(left), bottom: CGFloat(bottom), right: CGFloat(right))
     }
 }
 */
extension CGRect {
    init(x: Float, y: Float, width: Float, height: Float) {
        self.init(x: Double(x), y: Double(y), width: Double(width), height: Double(height))
    }
    var bounds: CGRect {
        return CGRect(origin: .zero, size: size)
    }
}
extension CGRect {
    static func - (left: CGRect, right: UIEdgeInsets) -> CGRect {
        return left.inset(by: right)
    }
    static func + (left: CGRect, right: UIEdgeInsets) -> CGRect {
        var left = left
        left.size += right
        left.origin.x -= right.left
        left.origin.y -= right.top
        return left
    }
}
