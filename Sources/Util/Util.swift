//
//  Util.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import UIKit

func performInMainAsync(_ action: @escaping () -> Void) {
    if Thread.isMainThread {
        return action()
    } else {
        return DispatchQueue.main.async(execute: action)
    }
}
extension Collection {
    /// ZJaDe: 根据 size 把 Collection 拆分 相当于 chunk(size, 0)
    func chunk(_ size: UInt) -> AnySequence<SubSequence> {
        return AnySequence { () -> AnyIterator<SubSequence> in
            var temp = self.dropFirst(0)
            let size = Int(size)
            return AnyIterator({
                guard temp.count > 0 else { return nil }
                let size: Int = size > 0 ? size : temp.count
                defer { temp = temp.dropFirst(size) }
                return temp.prefix(size)
            })
        }
    }
}
func assertInMain(file: StaticString = #file, line: UInt = #line) {
    /**
     经过不断测试，发现若是支持多线程，计算过程中计算view的尺寸需要同步切换到主线程，然后返回异步线程。
     线程之间来回切换，以及一些多余的兼容代码，会导致布局性能下降。
     综合成本算下来，强制只在主线程执行布局计算，是该框架性能最高的方式。
     UIKit误终身🙂
     */
    /**
     考虑了下，写了支持多线程的代码，不过view计算尺寸调用sizeThatFits的时候，还是线程不安全的。
     */
//    assert(Thread.isMainThread, "当前方法需要在主线程执行", file: file, line: line)
}
