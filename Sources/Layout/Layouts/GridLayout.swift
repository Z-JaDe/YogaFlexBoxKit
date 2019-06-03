//
//  GridLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/31.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
public enum GridJustify {
    case flexStart
    case flexEnd
    case center

    case spaceBetween
    case spaceAround
    case spaceEvenly
    
    case fill
    case fillEqually
    
    var isFillEqual: Bool {
        return self == .fillEqually
    }
    var isFill: Bool {
        return self == .fillEqually || self == .fill
    }
}
public enum GridFlexDirection {
    case row
    case column
}
///处理指定数量后换行
public class GridLayout: LeafLayout {
    public var flexDirection: GridFlexDirection = .row {
        didSet { makeDirty() }
    }
    public var justifyContent: GridJustify = .fill {
        didSet { makeDirty() }
    }
    public var alignContent: GridJustify = .flexStart {
        didSet { makeDirty() }
    }
    public var lineSpace: CGFloat = 0 {
        didSet { makeDirty() }
    }
    public var itemSpace: CGFloat = 0 {
        didSet { makeDirty() }
    }
    public var lineLength: UInt = 0 {
        didSet { makeDirty() }
    }
    
    var gridChilds: AnySequence<ArraySlice<YogaLayoutable>> {
        return self.childs.lazy
            .filter({$0.yoga.isIncludedInLayout})
            .chunk(self.lineLength)
    }

}

extension GridLayout: LeafLayoutProtocol {
    public func frameDidChanged(oldFrame: CGRect, newFrame: CGRect) {
        let size = self.flexDirection == .row ? newFrame.size : newFrame.size.reversed()
        let lineLength: CGFloat = CGFloat(self.lineLength)
        let lineCount: CGFloat = CGFloat(self.lineCount)
        let contentSize: CGSize = CGSize(
            width: size.width - self.itemSpace * (lineLength - 1),
            height: size.height - self.lineSpace * (lineCount - 1)
        )
//        var itemInfosArr = self.calculateItemInfos(size)
//        for itemInfos in itemInfosArr {
//            for itemInfo in itemInfos {
//                
//            }
//        }
    }
//    func calculateItemInfos(_ size: CGSize) -> [[ItemSpec]] {
//        let equalSize = CGSize(
//            width: equalItemSize(size.width, isLine: true),
//            height: equalItemSize(size.height, isLine: false)
//        )
//        return self.gridChilds.map {$0.map { (item) -> ItemInfo in
//            var itemInfo: ItemInfo = ItemInfo(item)
//            if self.justifyContent.isFillEqual {
//                itemInfo.size.width = equalSize.width
//            } else {
//                itemInfo.size.width = itemInfo.intrinsicSize.width
//            }
//            if self.alignContent.isFillEqual {
//                itemInfo.size.height = equalSize.height
//            } else {
//                itemInfo.size.height = itemInfo.intrinsicSize.height
//            }
//            return itemInfo
//        }}
//    }
    public func calculateSize(_ size: CGSize) -> CGSize {
        let size = self.flexDirection == .row ? size : size.reversed()
        var width: CGFloat = 0
        var height: CGFloat = 0
        let itemContainerSize = CGSize(
            width: self.justifyContent.isFillEqual ? equalItemSize(size.width, isLine: true) : .nan,
            height: self.alignContent.isFillEqual ? equalItemSize(size.height, isLine: false) : .nan
        )
        let lineLength: CGFloat = CGFloat(self.lineLength)
        let lineCount: CGFloat = CGFloat(self.lineCount)
        for childs in self.gridChilds {
            var lineWidth: CGFloat = 0
            var lineHeight: CGFloat = 0
            for item in childs {
                let itemSize = item.calculateLayout(with: itemContainerSize)
                if self.justifyContent.isFillEqual && itemSize.width > lineWidth {
                    lineWidth = itemSize.width
                } else {
                    lineWidth += itemSize.width
                }
                if itemSize.height > lineHeight { lineHeight = itemSize.height }
            }
            if self.justifyContent.isFillEqual { lineWidth *= lineLength }
            if lineWidth > width { width = lineWidth }
            if self.alignContent.isFillEqual && lineHeight > height {
                height = lineHeight
            } else {
                height += lineHeight
            }
        }
        if self.alignContent.isFillEqual { height *= lineCount }
        width += self.itemSpace * (lineLength - 1)
        height += self.lineSpace * (lineCount - 1)
        switch self.flexDirection {
        case .row:
            return CGSize(width: width, height: height)
        case .column:
            return CGSize(width: height, height: width)
        }
    }
    func equalItemSize(_ containerSize: CGFloat, isLine: Bool) -> CGFloat {
        guard self.childs.count > 0 else {
            return .zero
        }
        if containerSize.isNaN || containerSize <= 0 || containerSize == .greatestFiniteMagnitude {
            return .nan
        }
        if isLine {
            let lineLength: CGFloat = CGFloat(self.lineLength)
            return (containerSize - (lineLength - 1) * self.itemSpace) / lineLength
        } else {
            let lineCount: CGFloat = CGFloat(self.lineCount)
            return (containerSize - (lineCount - 1) * self.lineSpace) / lineCount
        }
    }
    var lineCount: Int {
        let totalCount = self.childs.count
        guard totalCount > 0 else {
            return 0
        }
        switch self.lineLength {
        case 0: return 1
        case 1: return totalCount
        case let columnNum where columnNum > 1:
            return (totalCount - 1) / Int(columnNum) + 1
        default:
            assertionFailure("不可能为负数")
            return 1
        }
    }
}
