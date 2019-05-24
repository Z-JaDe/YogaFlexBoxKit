//
//  Layoutable.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public protocol Layoutable: class {
    var frame: CGRect {get set}
    var yoga: LayoutNode {get}
    var childs: [Layoutable] {get}
    var superLayout: Layoutable? {get}
    func sizeThatFits(_ size: CGSize) -> CGSize
}
public extension Layoutable {
    func sizeThatFits(_ size: CGSize) -> CGSize {
        return .zero
    }
    var size: CGSize {
        return self.frame.size
    }
}
