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
//    assert(Thread.isMainThread, "当前方法需要在主线程执行", file: file, line: line)
}
