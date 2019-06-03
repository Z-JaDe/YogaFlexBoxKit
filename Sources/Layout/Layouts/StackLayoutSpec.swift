//
//  StackLayoutSpec.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

struct StackLayoutSpec {
    var flexDirection: GridFlexDirection = .row
    var distribution: GridJustify = .fill
    var spacing: CGFloat = 0
}
extension StackLayoutSpec {
    func setChildFrames(_ newFrame: CGRect, _ childs: [YogaLayoutable]) {
        let size = self.flexDirection == .row ? newFrame.size : newFrame.size.reversed()
        var itemSpacs = getItemSpecs(size, childs)
        let allItemSize = adjustItemSize(&itemSpacs, size)
        let childCount = CGFloat(childs.count)
        let startSpace = getStartSpace(size, allItemSize, childCount)
        let spacing = getSpaceing(size, allItemSize, childCount)
        adjustItemOrigin(&itemSpacs, startSpace, spacing)
        for (itemSpec, child) in zip(itemSpacs, childs) {
            var frame: CGRect = .zero
            if self.flexDirection == .row {
                frame.size = itemSpec.size.pixelValue
                frame.origin = itemSpec.origin.pixelValue + newFrame.origin
            } else {
                frame.size = itemSpec.size.reversed().pixelValue
                frame.origin = itemSpec.origin.reversed().pixelValue + newFrame.origin
            }
            child.frame = frame
        }
    }
    func calculateSize(_ size: CGSize, _ childs: [YogaLayoutable]) -> CGSize {
        var size = self.flexDirection == .row ? size : size.reversed()
        size.height = .nan
        let result = calculateItemsSize(getItemSpecs(size, childs))
        return self.flexDirection == .row ? result : result.reversed()
    }
}
extension StackLayoutSpec {
    func adjustItemOrigin(_ itemSpecs: inout [ItemSpec], _ startSpace: CGFloat, _ spacing: CGFloat) {
        var last: ItemSpec?
        itemSpecs = itemSpecs.enumerated().map { (offset, itemSpec) -> ItemSpec in
            var itemSpec = itemSpec
            if let last = last {
                itemSpec.origin.x = last.maxX + spacing
            } else {
                itemSpec.origin.x = startSpace
            }
            last = itemSpec
            return itemSpec
        }
    }
    func getStartSpace(_ size: CGSize, _ allItemSize: CGSize, _ childCount: CGFloat) -> CGFloat {
        switch self.distribution {
        case .fill, .fillEqually, .flexStart, .spaceBetween:
            return 0
        case .center:
            return (size.width - allItemSize.width) / 2
        case .flexEnd:
            return size.width - allItemSize.width
        case .spaceAround, .spaceEvenly:
            let totalSpace = size.width - allItemSize.width + (childCount - 1) * self.spacing
            if self.distribution == .spaceAround {
                return totalSpace / childCount / 2
            } else if self.distribution == .spaceEvenly {
                return totalSpace / (childCount + 1)
            } else {
                assertionFailure("未处理的枚举")
                return self.spacing
            }
        }
    }
    var isFixed: Bool {
        switch self.distribution {
        case .fill, .fillEqually, .center, .flexStart, .flexEnd:
            return true
        case .spaceAround, .spaceBetween, .spaceEvenly:
            return false
        }
    }
    func getSpaceing(_ size: CGSize, _ allItemSize: CGSize, _ childCount: CGFloat) -> CGFloat {
        if self.isFixed {
            return self.spacing
        }
        let totalSpace = size.width - allItemSize.width + (childCount - 1) * self.spacing
        if self.distribution == .spaceBetween {
            return totalSpace / (childCount - 1)
        } else if self.distribution == .spaceAround {
            return totalSpace / childCount
        } else if self.distribution == .spaceEvenly {
            return totalSpace / (childCount + 1)
        } else {
            assertionFailure("未处理的枚举")
            return self.spacing
        }
    }
    ///比较计算出的尺寸 和 想要设置的尺寸，修改itemSpe的size
    func adjustItemSize(_ itemSpecs: inout [ItemSpec], _ size: CGSize) -> CGSize {
        let childCount = CGFloat(itemSpecs.count)
        var allItemSize = calculateItemsSize(itemSpecs)
        let widthSpace = (allItemSize.width - size.width) / childCount
        let heightSpace = allItemSize.height - size.height
        if widthSpace <= 0 && heightSpace <= 0 && self.distribution.isFill == false {
            return allItemSize
        }
        if widthSpace > 0 {
            allItemSize.width = size.width
        }
        if heightSpace > 0 {
            allItemSize.height = size.height
        }
        itemSpecs = itemSpecs.map { (itemSpec) -> ItemSpec in
            var itemSpec = itemSpec
            if widthSpace > 0 || self.distribution.isFill {
                itemSpec.size.width -= widthSpace
            }
            if heightSpace > 0 {
                itemSpec.size.height -= heightSpace
            }
            return itemSpec
        }
        return allItemSize
    }
}
extension StackLayoutSpec {
    ///根据childs和size 生成 itemSpec
    func getItemSpecs(_ size: CGSize, _ childs: [YogaLayoutable]) -> [ItemSpec] {
        guard childs.count > 0 else { return [] }
        let childCount = CGFloat(childs.count)
        let totalSpace = (childCount - 1) * self.spacing
        let itemContainerSize: CGSize = CGSize(
            width: self.distribution.isFillEqual ? (size.width - totalSpace) / childCount : .nan,
            height: size.height
        )
        return childs.map { (child) -> ItemSpec in
            var itemSpec = ItemSpec(child)
            let itemSize = child.calculateLayout(with: itemContainerSize)
            itemSpec.size = self.flexDirection == .row ? itemSize : itemSize.reversed()
            itemSpec.size.height = size.height
            return itemSpec
        }
    }
    ///计算itemSpecs加上space的最适合尺寸
    func calculateItemsSize(_ itemSpecs: [ItemSpec]) -> CGSize {
        guard itemSpecs.count > 0 else { return .zero }
        let childCount = CGFloat(itemSpecs.count)
        var result: CGSize = .zero
        for itemSpec in itemSpecs {
            let itemSize = itemSpec.size
            if self.distribution.isFillEqual && result.width < itemSize.width {
                result.width = itemSize.width
            } else {
                result.width += itemSize.width
            }
            if result.height < itemSize.height { result.height = itemSize.height }
        }
        if self.distribution.isFillEqual {
            result.width *= childCount
        }
        result.width += (childCount - 1) * self.spacing
        return result
    }
}
