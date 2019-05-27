//
//  Util.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import UIKit
private let scale = UIScreen.main.scale
extension CGFloat {
    var pixelValue: CGFloat {
        return Foundation.round(self * scale) / scale
    }
}

extension CGPoint {
    init(x: Float, y: Float) {
        self.init(x: Double(x), y: Double(y))
    }
}
extension CGSize {
    init(width: Float, height: Float) {
        self.init(width: Double(width), height: Double(height))
    }
}
extension CGRect {
    init(x: Float, y: Float, width: Float, height: Float) {
        self.init(x: Double(x), y: Double(y), width: Double(width), height: Double(height))
    }
}

extension FloatingPoint {
    public static func random(min: Self = 0, max: Self = 1) -> Self {
        let diff = max - min
        let rand = Self(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Self(RAND_MAX)) * diff) + min
    }
}
