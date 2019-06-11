//
//  FloatingPoint.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

private let scale = UIScreen.main.scale
extension CGFloat {
    var pixelValue: CGFloat {
        return Foundation.round(self * scale) / scale
    }
}
extension CGFloat {
    var isNaNOrMax: Bool {
        return isNaN || self == .greatestFiniteMagnitude
    }
}
extension BinaryFloatingPoint where Self.RawSignificand: FixedWidthInteger {
    /// ZJaDe: 返回随机数
    public static func random(min: Self = 0, max: Self = 1) -> Self {
        return random(in: min...max)
    }
}
