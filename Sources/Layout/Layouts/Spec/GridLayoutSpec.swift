//
//  GridLayoutSpec.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/4.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

class GridLayoutSpec: MultipleItemsSpec {
    var lineSpace: CGFloat {
        get {return super.spacing}
        set {super.spacing = newValue}
    }
    var justifyContent: GridJustify = .fill {
        didSet {invalidateIntrinsicSize()}
    }
    var itemSpace: CGFloat = 0
    
    var childs: [StackLayoutSpec] = [] {
        didSet { invalidateIntrinsicSize() }
    }
    override func calcuateItemSpecs() -> [ItemSpec] {
        return childs.map({mapItemSpec($0.intrinsicSize)})
    }
}
extension GridLayoutSpec {
    func setChildFrames(_ newFrame: CGRect, _ itemEqual: GridItemEqual, _ lineLength: Int) {
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
            if lineLength != child.childs.count {
                switch itemEqual {
                case .everyLineSize, .everyLineSizeAndAllHieght, .none:
                    child.wantChildCount = nil
                case .allSize:
                    child.wantChildCount = lineLength
                }
            }
            child.setChildFrames(frame)
        }
    }
}
