//
//  CGSize.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension CGSize {
    init(width: Float, height: Float) {
        self.init(width: Double(width), height: Double(height))
    }
    static var nan: CGSize {
        return CGSize(width: CGFloat.nan, height: CGFloat.nan)
    }
    var isNaN: Bool {
        return self.width.isNaN && self.height.isNaN
    }
    var pixelValue: CGSize {
        return CGSize(width: width.pixelValue, height: height.pixelValue)
    }
    func reversed() -> CGSize {
        return CGSize(width: height, height: width)
    }
}
extension CGSize {
    static func + (left: CGSize, right: UIEdgeInsets) -> CGSize {
        var left = left
        left.width += right.left + right.right
        left.height += right.top + right.bottom
        return left
    }
    static func += (left: inout CGSize, right: UIEdgeInsets) {
        // swiftlint:disable shorthand_operator
        left = left + right
    }
    static func - (left: CGSize, right: UIEdgeInsets) -> CGSize {
        var left = left
        left.width -= right.left + right.right
        left.height -= right.top + right.bottom
        left.width = max(left.width, 0)
        left.height = max(left.height, 0)
        return left
    }
    static func -= (left: inout CGSize, right: UIEdgeInsets) {
        // swiftlint:disable shorthand_operator
        left = left - right
    }
}
