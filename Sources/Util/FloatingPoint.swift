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

extension FloatingPoint {
    static func random(min: Self = 0, max: Self = 1) -> Self {
        let diff = max - min
        let rand = Self(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Self(RAND_MAX)) * diff) + min
    }
}
