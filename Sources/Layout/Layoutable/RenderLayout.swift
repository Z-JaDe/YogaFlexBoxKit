//
//  RenderLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
import yoga

open class RenderLayout: FlexBoxKit, YogaLayoutable {
    public private(set) lazy var yoga: LayoutNode = LayoutNode(target: self)
    public private(set) weak var superLayout: YogaLayoutable?
    public private(set) var childs: [YogaLayoutable] = []
    var _frame: CGRect = .zero
    public var frame: CGRect {
        get { return _frame }
        set {
            let oldValue = _frame
            _frame = newValue
            layoutDidChanged(oldFrame: oldValue)
        }
    }
    public override init() {
        super.init()
        configInit()
    }
    open func configInit() {
        
    }
    public final func changePrivateFrame(_ frame: CGRect) {
        let oldValue = self._frame
        self._frame = frame
        privateFrameDidChanged(oldFrame: oldValue)
    }
    ///内部设置frame时监听，只是更新view frame
    open func privateFrameDidChanged(oldFrame: CGRect) {

    }
    ///外部设置frame时监听，会触发child计算自己的frame
    open func layoutDidChanged(oldFrame: CGRect) {
//        guard oldFrame != self.frame else { return } //有可能childs变化
        /**
         叶子节点的时候，不需要重新yoga计算，但是需要更新下内部一些配置
         非叶子节点frame主动被改，需要更新计算下childs
        */
        if isLeaf {
            privateFrameDidChanged(oldFrame: oldFrame)
        } else {
            let frame = self.frame
            ///该方法走完会走下_frameDidChanged
            self.applyLayout(origin: frame.origin, size: frame.size)
        }
    }
    /// 叶子节点的时候 yoga根据该方法返回一个适合的尺寸
    open func sizeThatFits(_ size: CGSize) -> CGSize {
        return .zero
    }
    open var isLeaf: Bool {
        return _isLeaf
    }
    
    @discardableResult
    open func calculateLayout(with size: CGSize) -> CGSize {
        return yoga.calculateYogaLayout(with: size)
    }
    open func applyLayout(origin: CGPoint, size: CGSize) {
        yoga.applyLayout(origin: origin, size: size)
    }
}

extension RenderLayout {
    internal func _addChild(_ child: YogaLayoutable) {
        self.childs.append(child)
        child.setSuperLayout(self)
    }
    internal func _removeChild(_ child: YogaLayoutable) {
        if let index = self.childs.firstIndex(where: {child === $0}) {
            self.childs.removeFirst(index)
            child.setSuperLayout(nil)
        }
    }
    internal func _removeAllChild() {
        self.childs.forEach { (child) in
            child.setSuperLayout(nil)
        }
        self.childs.removeAll()
    }
    internal func _setSuperLayout(_ layout: YogaLayoutable?) {
        if let superLayout = self.superLayout, layout != nil {
            assertionFailure("layout已经拥有superLayout->\(superLayout)")
        }
        self.superLayout = layout
    }
}
extension YogaLayoutable {
    fileprivate func setSuperLayout(_ layout: YogaLayoutable?) {
        if let child = self as? RenderLayout {
            child._setSuperLayout(layout)
        } else if let child = self as? UIView {
            child._setSuperLayout(layout)
        }
    }
}
