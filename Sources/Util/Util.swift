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
    static var nan: CGSize {
        return CGSize(width: CGFloat.nan, height: CGFloat.nan)
    }
    var isNaN: Bool {
        return self.width.isNaN && self.height.isNaN
    }
}
extension CGRect {
    init(x: Float, y: Float, width: Float, height: Float) {
        self.init(x: Double(x), y: Double(y), width: Double(width), height: Double(height))
    }
}
extension CGRect {
    public static func - (left: CGRect, right: UIEdgeInsets) -> CGRect {
        return left.inset(by: right)
    }
    public static func + (left: CGRect, right: UIEdgeInsets) -> CGRect {
        var left = left
        left.size += right
        left.origin.x -= right.left
        left.origin.y -= right.top
        return left
    }
}
extension CGSize {
    public static func + (left: CGSize, right: UIEdgeInsets) -> CGSize {
        var left = left
        left.width += right.left + right.right
        left.height += right.top + right.bottom
        return left
    }
    public static func += (left: inout CGSize, right: UIEdgeInsets) {
        // swiftlint:disable shorthand_operator
        left = left + right
    }
    public static func - (left: CGSize, right: UIEdgeInsets) -> CGSize {
        var left = left
        left.width -= right.left + right.right
        left.height -= right.top + right.bottom
        left.width = max(left.width, 0)
        left.height = max(left.height, 0)
        return left
    }
    public static func -= (left: inout CGSize, right: UIEdgeInsets) {
        // swiftlint:disable shorthand_operator
        left = left - right
    }
}

extension FloatingPoint {
    public static func random(min: Self = 0, max: Self = 1) -> Self {
        let diff = max - min
        let rand = Self(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Self(RAND_MAX)) * diff) + min
    }
}

func performInMainAsync(_ action: @escaping () -> Void) {
    if Thread.isMainThread {
        return action()
    } else {
        return DispatchQueue.main.async(execute: action)
    }
}

func assertInMain(file: StaticString = #file, line: UInt = #line) {
    /**
     经过不断测试，发现若是支持多线程，计算过程中计算view的尺寸需要同步切换到主线程，然后返回异步线程。
     线程之间来回切换，以及一些多余的兼容代码，会导致布局性能下降。
     即使愿意牺牲一部分性能，换来支持多线程，多线程使用不当有可能会导致性能下降2-3个数量级。
     综合成本算下来，强制只在主线程执行布局计算，是该框架性能最高的方式。
     UIKit误终身🙂
     */
    /**
     考虑了下，写了支持多线程的代码，不过view计算尺寸调用sizeThatFits的时候，还是线程不安全的。
     */
//    assert(Thread.isMainThread, "当前方法需要在主线程执行", file: file, line: line)
}
