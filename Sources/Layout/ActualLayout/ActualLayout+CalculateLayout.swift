//
//  ActualLayout+CalculateLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/30.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension ActualLayout: YogaCalculateLayoutable {
    func sizeThatFits(_ size: CGSize) -> CGSize {
        return view!.sizeThatFits(size)
    }
    var intrinsicSize: CGSize {
        return self.calculateLayout(with: CGSize.nan)
    }
    func calculateLayout(with size: CGSize) -> CGSize {
        return yoga.calculateLayout(with: size)
    }
    func applyLayout(preserveOrigin: Bool, size: CGSize) {
        var size = size
        if isScroll {
            size.height = CGFloat.nan
        }
        let origin = preserveOrigin ? self.frame.origin : .zero
        yoga.calculateLayout(with: size)
        yoga.applyLayoutToViewHierarchy(origin: origin)
        performInMainAsyncIfNeed {
            self.updateChildViewFrame()
        }
    }
}
