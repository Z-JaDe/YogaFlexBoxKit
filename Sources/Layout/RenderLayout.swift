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
    public private(set) weak var superLayout: Layoutable?
    public private(set) var childs: [Layoutable] = []
    var _frame: CGRect = .zero {
        didSet { _frameDidChanged(oldFrame: oldValue) }
    }
    public var frame: CGRect {
        get { return _frame }
        set {
            let oldValue = _frame
            _frame = newValue
            layoutDidChanged(oldFrame: oldValue)
        }
    }
    init() {
        configInit()
    }
    open func configInit() {
        
    }
    open func _frameDidChanged(oldFrame: CGRect) {
        
    }
    open func layoutDidChanged(oldFrame: CGRect) {
        
    }
}

extension RenderLayout {
    internal func _addChild(_ child: Layoutable) {
        self.childs.append(child)
        if let layout = self as? Layoutable {
            (child as? RenderLayout)?.setSuperLayout(layout)
        }
    }
    func setSuperLayout(_ layout: Layoutable) {
        if let superLayout = self.superLayout {
            assertionFailure("layout已经拥有superLayout->\(superLayout)")
        }
        self.superLayout = layout
    }
}
