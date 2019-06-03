//
//  ItemSpec.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

struct ItemSpec {
    let item: YogaLayoutable
    var size: CGSize = .zero
    var origin: CGPoint = .zero
    lazy var intrinsicSize: CGSize = item.calculateLayout(with: .nan)
    init(_ item: YogaLayoutable) {
        self.item = item
    }
    var maxX: CGFloat {
        return self.size.width + self.origin.x
    }
}
