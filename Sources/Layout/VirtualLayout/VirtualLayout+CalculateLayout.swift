//
//  VirtualLayout+CalculateLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/30.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension VirtualLayout {
    func sizeThatFits(_ size: CGSize) -> CGSize {
        return .zero
    }
    var intrinsicSize: CGSize {
        return self.calculateLayout(with: CGSize.nan)
    }
    @discardableResult
    func calculateLayout(with size: CGSize) -> CGSize {
        return yoga.calculateLayout(with: size)
    }
}
extension VirtualLayout: YogaCalculateLayoutable {
    var isScroll: Bool {
        return child.isScroll
    }
    var containerSize: CGSize {
        return child.containerSize + edgesInset()
    }
    func applyLayout(preserveOrigin: Bool, size: CGSize) {
        yoga.applyLayout(preserveOrigin: preserveOrigin, size: size)
    }
}
