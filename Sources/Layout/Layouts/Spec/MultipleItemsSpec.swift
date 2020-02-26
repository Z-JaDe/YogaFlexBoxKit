//
//  MultipleItemsSpec.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/4.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

class MultipleItemsSpec {
    var flexDirection: GridFlexDirection = .row {
        didSet { invalidateIntrinsicSize() }
    }
    var alignContent: GridJustify = .fill {
        didSet { invalidateIntrinsicSize() }
    }
    var spacing: CGFloat = 0 {
        didSet { invalidateIntrinsicSize() }
    }
    var allItemEqual: Bool = false {
        didSet { invalidateIntrinsicSize() }
    }
    /**
     grid布局时有时最后一行不是满一行的，却想按照满的来设置item尺寸和位置。
     如果wantChildCount为nil，表示使用本来的count
     如果wantChildCount大于0，表示使用wantChildCount布局
     */
    var wantChildCount: Int?

    private var _intrinsicSize: CGSize?
    func calculateIntrinsicSize() -> CGSize {
        var size = calculateItemsSize(self.itemSpecs)
        size.width += self.innerTotalSpacing
        size = self.flexDirection == .row ? size : size.reversed()
        return size
    }
    private var _itemSpecs: [ItemSpec]?
    func calcuateItemSpecs() -> [ItemSpec] {
        return []
    }
}
extension MultipleItemsSpec {
    var intrinsicSize: CGSize {
        if let size = _intrinsicSize {
            return size
        }
        let size = calculateIntrinsicSize()
        _intrinsicSize = size
        return size
    }
    func invalidateIntrinsicSize() {
        invalidateItemSpecs()
        _intrinsicSize = nil
    }

    var itemSpecs: [ItemSpec] {
        if let specs = _itemSpecs {
            return specs
        }
        let specs = calcuateItemSpecs()
        _itemSpecs = specs
        return specs
    }
    func invalidateItemSpecs() {
        _itemSpecs = nil
    }
}
extension MultipleItemsSpec {
    private func getChildCount(_ count: Int) -> CGFloat {
        if let count = wantChildCount, count > 0 {
            return CGFloat(count)
        }
        return CGFloat(count)
    }
}
extension MultipleItemsSpec {
    func _setChildFrame(_ newFrame: CGRect) -> [ItemSpec] {
        let size = self.flexDirection == .row ? newFrame.size : newFrame.size.reversed()
        var itemSpacs = self.itemSpecs
        let childCount = getChildCount(itemSpacs.count)
        let allItemSize = adjustItemSize(&itemSpacs, size)
        switch self.alignContent {
        case .center, .flexEnd, .flexStart, .fill, .spaceAround, .spaceBetween, .spaceEvenly:
            let startSpace = getStartSpace(size, allItemSize, childCount)
            let spacing = getSpaceing(size, allItemSize, childCount)
            adjustItemOrigin(&itemSpacs) {
                adjustItemOriginEqualSpaceing($0, &$1, startSpace, spacing)
            }
        case .centerEvenly, .centerAround:
            let spacing = getCenterSpaceing(size, childCount)
            let startSpace = getCenterStartSpaceing(size, childCount)
            adjustItemOrigin(&itemSpacs) {
                adjustItemOriginEqualCentering($0, &$1, startSpace, spacing)
            }
        }
        return itemSpacs
    }
}
extension MultipleItemsSpec {
    func adjustItemOrigin(_ itemSpecs: inout [ItemSpec], _ closure: (ItemSpec?, inout ItemSpec) -> Void) {
        var last: ItemSpec?
        itemSpecs = itemSpecs.enumerated().map { (_, itemSpec) -> ItemSpec in
            var itemSpec = itemSpec
            closure(last, &itemSpec)
            last = itemSpec
            return itemSpec
        }
    }
    func adjustItemOriginEqualSpaceing(_ last: ItemSpec?, _ itemSpec: inout ItemSpec, _ startSpace: CGFloat, _ spacing: CGFloat) {
        if let last = last {
            itemSpec.origin.x = last.maxX + spacing
        } else {
            itemSpec.origin.x = startSpace
        }
    }
    func adjustItemOriginEqualCentering(_ last: ItemSpec?, _ itemSpec: inout ItemSpec, _ startSpace: CGFloat, _ spacing: CGFloat) {
        if let last = last {
            itemSpec.centerX = last.centerX + spacing
        } else {
            itemSpec.centerX = startSpace
        }
    }
    ///比较计算出的尺寸 和 想要设置的尺寸，修改itemSpe的size
    func adjustItemSize(_ itemSpecs: inout [ItemSpec], _ size: CGSize) -> CGSize {
        let childCount = getChildCount(itemSpecs.count)
        ///计算出不包含间距的内容大小
        let size: CGSize = CGSize(
            width: size.width - self.innerTotalSpacing,
            height: size.height
        )
        var allItemSize = calculateItemsSize(itemSpecs)
        let widthSpace = (allItemSize.width - size.width) / childCount
        let heightSpace = allItemSize.height - size.height

        if widthSpace > 0 || self.allItemEqual {
            allItemSize.width = size.width
        }
        if heightSpace > 0 || self.alignContent.isFill {
            allItemSize.height = size.height
        }

        itemSpecs = itemSpecs.map { (itemSpec) -> ItemSpec in
            var itemSpec = itemSpec
            if self.allItemEqual {
                //allItemEqual时所有item是相等的
                itemSpec.size.width = size.width / childCount
            } else if widthSpace > 0 || self.alignContent.isFill {
                //如果需要是填充类型，或者内容太多，按照内容等比缩放
                itemSpec.size.width -= widthSpace
            }
//            if heightSpace > 0 || self.alignContent.isFill {
//                //如果内容太多，或者是填充类型，直接让item高度和size相等
//                itemSpec.size.height = size.height
//            } else {
//                //alignItem 如水平布局时 高度默认等于最大的那个
//                itemSpec.size.height = allItemSize.height
//            }
            itemSpec.size.height = size.height
            return itemSpec
        }
        return allItemSize
    }
    ///计算itemSpecs最适合尺寸
    func calculateItemsSize(_ itemSpecs: [ItemSpec]) -> CGSize {
        let childCount = getChildCount(itemSpecs.count)
        guard childCount > 0 else { return .zero }
        var result: CGSize = .zero
        for itemSpec in itemSpecs {
            let itemSize = itemSpec.size
            if self.allItemEqual {
                if result.width < itemSize.width { result.width = itemSize.width }
            } else {
                result.width += itemSize.width
            }
            if result.height < itemSize.height { result.height = itemSize.height }
        }
        if self.allItemEqual {
            result.width *= childCount
        }
        return result
    }
}

extension MultipleItemsSpec {
    ///根据childs的size 生成 itemSpec
    func mapItemSpec(_ itemSize: CGSize) -> ItemSpec {
        var itemSpec = ItemSpec()
        itemSpec.size = self.flexDirection == .row ? itemSize : itemSize.reversed()
        return itemSpec
    }
    func getStartSpace(_ size: CGSize, _ allItemSize: CGSize, _ childCount: CGFloat) -> CGFloat {
        switch self.alignContent {
        case .fill, .flexStart, .spaceBetween:
            return 0
        case .center:
            //总大小减去所有item大小 再减去item之间间距的大小 除以2
            return (size.width - allItemSize.width - self.innerTotalSpacing) / 2
        case .flexEnd:
            //总大小减去所有item大小 再减去item之间间距的大小
            return size.width - allItemSize.width - self.innerTotalSpacing
        case .spaceAround, .spaceEvenly:
            //总大小减去所有item大小 忽略 spacing
            let totalSpace = size.width - allItemSize.width
            if self.alignContent == .spaceAround {
                return totalSpace / childCount / 2
            } else if self.alignContent == .spaceEvenly {
                return totalSpace / (childCount + 1)
            } else {
                assertionFailure("未处理的枚举")
                return self.spacing
            }
        case .centerEvenly, .centerAround:
            assertionFailure("不使用这个方法处理")
            return 0
        }
    }
    ///item之间的所有间距之和
    var innerTotalSpacing: CGFloat {
        var spaceCount = getChildCount(itemSpecs.count)
        switch self.alignContent {
        case .spaceAround, .centerAround: break
        case .spaceEvenly, .centerEvenly:
            spaceCount += 1
        case .center, .fill, .flexStart, .flexEnd, .spaceBetween:
            spaceCount -= 1
        }
        return spaceCount * self.spacing
    }
    private var isFixed: Bool {
        switch self.alignContent {
        case .fill, .center, .flexStart, .flexEnd:
            return true
        case .spaceAround, .spaceBetween, .spaceEvenly:
            return false
        case .centerEvenly, .centerAround:
            assertionFailure("不使用这个方法处理")
            return false
        }
    }
    func getSpaceing(_ size: CGSize, _ allItemSize: CGSize, _ childCount: CGFloat) -> CGFloat {
        if self.isFixed {
            return self.spacing
        }
        //总大小减去所有item大小 忽略 spacing
        let totalSpace = size.width - allItemSize.width
        if self.alignContent == .spaceBetween {
            return totalSpace / (childCount - 1)
        } else if self.alignContent == .spaceAround {
            return totalSpace / childCount
        } else if self.alignContent == .spaceEvenly {
            return totalSpace / (childCount + 1)
        } else {
            assertionFailure("未处理的枚举")
            return self.spacing
        }
    }
    func getCenterStartSpaceing(_ size: CGSize, _ childCount: CGFloat) -> CGFloat {
        switch self.alignContent {
        case .center, .flexEnd, .flexStart, .fill, .spaceAround, .spaceBetween, .spaceEvenly:
            assertionFailure("未处理的枚举")
            return self.spacing
        case .centerAround:
            return size.width / childCount / 2
        case .centerEvenly:
            return size.width / (childCount + 1)
        }
    }
    func getCenterSpaceing(_ size: CGSize, _ childCount: CGFloat) -> CGFloat {
        switch self.alignContent {
        case .center, .flexEnd, .flexStart, .fill, .spaceAround, .spaceBetween, .spaceEvenly:
            assertionFailure("未处理的枚举")
            return self.spacing
        case .centerAround:
            return size.width / childCount
        case .centerEvenly:
            return size.width / (childCount + 1)
        }
    }
}
