//
//  YogaLayoutable+Sub.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/29.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension ActualLayout: YogaLayoutable {
    func sizeThatFits(_ size: CGSize) -> CGSize {
        return view!.sizeThatFits(size)
    }
}
extension VirtualLayout: YogaLayoutable {
    func sizeThatFits(_ size: CGSize) -> CGSize {
        return .zero
    }
    var isLeaf: Bool {
        return false
    }
}
