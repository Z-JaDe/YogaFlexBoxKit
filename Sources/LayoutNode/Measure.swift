//
//  Measure.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/22.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

func measureView(_ node: YGNodeRef?, _ width: Float, _ widthMode: YGMeasureMode, _ height: Float, _ heightMode: YGMeasureMode) -> YGSize {
    let constrainedWidth = widthMode == .undefined ? Float.greatestFiniteMagnitude : width
    let constrainedHeight = heightMode == .undefined ? Float.greatestFiniteMagnitude : width

    let view: WrapLayout? = YGNodeGetContext(node).map({unsafeBitCast($0, to: WrapLayout.self)})
    let sizeThatFits: CGSize = view?.sizeThatFits(CGSize(width: constrainedWidth, height: constrainedHeight)) ?? .zero
    return YGSize(
        width: sanitizeMeasurement(constrainedWidth, Float(sizeThatFits.width), widthMode),
        height: sanitizeMeasurement(constrainedHeight, Float(sizeThatFits.height), heightMode))
}
func sanitizeMeasurement(_ constrainedSize: Float, _ measuredSize: Float,_ measureMode: YGMeasureMode) -> Float {
    switch measureMode {
    case .atMost: return min(constrainedSize, measuredSize)
    case .exactly: return constrainedSize
    case .undefined: return measuredSize
    @unknown default: return measuredSize
    }
}
