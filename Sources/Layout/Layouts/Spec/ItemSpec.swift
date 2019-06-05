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
