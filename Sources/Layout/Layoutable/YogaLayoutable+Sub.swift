//
//  YogaLayoutable+Sub.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/29.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension ActualLayout: YogaLayoutable {}
extension VirtualLayout: YogaLayoutable {
    var isLeaf: Bool {
        // 如果是yoga布局 需要确定子节点，如果是自己手动布局相当于就是一个叶子节点
        if isUseYogaLayout {
            return _isLeaf
        } else {
            return true
        }
    }
}
