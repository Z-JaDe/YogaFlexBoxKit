//
//  StackLayoutSpec.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

class StackLayoutSpec: MultipleItemsSpec {
    var childs: [YogaLayoutable] = [] {
        didSet { invalidateIntrinsicSize() }
    }
    override func calcuateItemSpecs() -> [ItemSpec] {
        return childs.map({mapItemSpec($0.calculateLayout(with: .nan))})
    }
}
extension StackLayoutSpec {
    func setChildFrames(_ newFrame: CGRect) {
        let itemSpacs = self._setChildFrame(newFrame)
        for (itemSpec, child) in zip(itemSpacs, childs) {
            var frame: CGRect = .zero
            if self.flexDirection == .row {
                frame.size = itemSpec.size.pixelValue
                frame.origin = itemSpec.origin.pixelValue + newFrame.origin
            } else {
                frame.size = itemSpec.size.reversed().pixelValue
                frame.origin = itemSpec.origin.reversed().pixelValue + newFrame.origin
            }
            child.setFrame(frame)
        }
    }
}
