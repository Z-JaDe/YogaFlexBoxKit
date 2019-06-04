//
//  ItemSpec.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

struct ItemSpec {
    var size: CGSize = .zero
    var origin: CGPoint = .zero
    init() {}
    var maxX: CGFloat {
        return self.size.width + self.origin.x
    }
}

public enum GridJustify {
    case flexStart
    case flexEnd
    case center
    
    case spaceBetween
    case spaceAround
    case spaceEvenly
    ///填充 根据内容大小等比缩放
    case fill
    
    var isFill: Bool {
        return self == .fill
    }
}
public enum GridFlexDirection {
    case row
    case column
    func reversed() -> GridFlexDirection {
        switch self {
        case .row: return .column
        case .column: return .row
        }
    }
}
