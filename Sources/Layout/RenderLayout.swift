//
//  RenderLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

open class RenderLayout {
    open lazy var yoga: LayoutNode = LayoutNode(target: self)

    open weak var superLayout: Layoutable?
    open var frame: CGRect = .zero {
        didSet { layoutChanged() }
    }
    init() {
        configInit()
    }
    open func configInit() {
        
    }

    open func layoutChanged() {
        
    }
}
