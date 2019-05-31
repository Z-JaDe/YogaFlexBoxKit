//
//  YogaLayoutable+Sub.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/29.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension ActualLayout: YogaLayoutable {
    public func sizeThatFits(_ size: CGSize) -> CGSize {
        return view!.sizeThatFits(size)
    }
}
extension VirtualLayout: YogaLayoutable {
    public func sizeThatFits(_ size: CGSize) -> CGSize {
        return .zero
    }
    public var isLeaf: Bool {
        return false
    }
}
extension GridLayout: YogaLayoutable {
    public func sizeThatFits(_ size: CGSize) -> CGSize {
        return .zero
    }
}
