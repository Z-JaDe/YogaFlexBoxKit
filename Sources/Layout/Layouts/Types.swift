//
//  Types.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/5.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

#if ObjcSupport

@objc
public enum GridJustify: Int {
    case flexStart
    case flexEnd
    case center
    
    case spaceBetween
    case spaceAround
    case spaceEvenly
    ///填充 根据内容大小等比缩放
    case fill
}
@objc
public enum GridFlexDirection: Int {
    case row
    case column
}
@objc
public enum GridItemEqual: Int {
    ///每个item默认使用自有尺寸, 根据情况缩放
    case none
    ///每一行每个item尺寸相等, 多行之间的item不一定相等
    case everyLineSize
    ///每一行每个item尺寸相等, 多行之间item只有高度相等
    case everyLineSizeAndAllHieght
    ///每个item之间尺寸相等
    case allSize
}
#else

public enum GridJustify {
    case flexStart
    case flexEnd
    case center
    
    case spaceBetween
    case spaceAround
    case spaceEvenly
    ///填充 根据内容大小等比缩放
    case fill
}
public enum GridFlexDirection {
    case row
    case column
}
public enum GridItemEqual {
    ///每个item默认使用自有尺寸, 根据情况缩放
    case none
    ///每一行每个item尺寸相等, 多行之间的item不一定相等
    case everyLineSize
    ///每一行每个item尺寸相等, 多行之间item只有高度相等
    case everyLineSizeAndAllHieght
    ///每个item之间尺寸相等
    case allSize
}

#endif


extension GridJustify {
    var isFill: Bool {
        return self == .fill
    }
}
extension GridFlexDirection {
    func reversed() -> GridFlexDirection {
        switch self {
        case .row: return .column
        case .column: return .row
        }
    }
}
