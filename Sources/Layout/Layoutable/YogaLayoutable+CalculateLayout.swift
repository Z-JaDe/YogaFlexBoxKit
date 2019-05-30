//
//  YogaCalculateLayoutable.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/29.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
public struct YGDimensionFlexibility: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    static let flexibleWidth = YGDimensionFlexibility(rawValue: 1 << 0)
    static let flexibleHeight = YGDimensionFlexibility(rawValue: 1 << 1)
}
public protocol YogaCalculateLayoutable: class {
    var containerSize: CGSize {get}
    var isScroll: Bool {get}
    var intrinsicSize: CGSize {get}
    func calculateLayout(with size: CGSize) -> CGSize
    func applyLayout(preserveOrigin: Bool, size: CGSize)
}

public extension YogaCalculateLayoutable {
    func applyLayout(preserveOrigin: Bool = false) {
        applyLayout(preserveOrigin: preserveOrigin, size: containerSize)
    }
    func applyLayout(preserveOrigin: Bool, size: CGSize, dimensionFlexibility: YGDimensionFlexibility) {
        var size: CGSize = size
        if dimensionFlexibility.contains(.flexibleWidth) {
            size.width = CGFloat.nan
        }
        if dimensionFlexibility.contains(.flexibleHeight) || isScroll {
            size.height = CGFloat.nan
        }
        applyLayout(preserveOrigin: preserveOrigin, size: size)
    }
}

/** 本想等计算好布局后再设置view的frame。但是yoga本身就是先计算好frame，然后统一设置一遍frame。所以这样做没意义，反而还要多写了一些兼容代码，故去除
 重新使用这个方法是想把设置frame的代码都统一一次性放到主线程里面执行
 */
extension YogaLayoutable {
    func updateChildViewFrame() {
        switch self {
        case let layout as ActualUpdateLayoutProtocol & YogaLayoutable:
            layout.updateViewFrame(layout.frame)
            layout.childs.forEach({$0.updateChildViewFrame()})
        case let layout as VirtualLayoutCompatible:
            return layout.child.updateChildViewFrame()
        default: assertionFailure("未知的类型")
        }
    }
}
