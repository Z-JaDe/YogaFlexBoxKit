//
//  StackLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public class StackLayout: LeafLayout {
    let spec: StackLayoutSpec = StackLayoutSpec()
}
extension StackLayout: LeafLayoutProtocol {
    public func frameDidChanged(oldFrame: CGRect, newFrame: CGRect) {
        updateSpecChild()
        if self.yoga.isDirty {
            self.spec.invalidateIntrinsicSize()
        }
        self.spec.setChildFrames(newFrame.bounds)
    }
    public func leafCalculate(size: CGSize) -> CGSize {
        updateSpecChild()
        if self.yoga.isDirty {
            self.spec.invalidateIntrinsicSize()
        }
        return self.spec.intrinsicSize
    }
    func updateSpecChild() {
        if self.hasExactSameChildren(self.spec.childs) {
            return
        }
        self.spec.childs = self.canUseChilds
    }

    @objc
    public var flexDirection: GridFlexDirection {
        get {return spec.flexDirection}
        set {spec.flexDirection = newValue}
    }
    @objc
    public var distribution: GridJustify {
        get {return spec.alignContent}
        set {spec.alignContent = newValue}
    }
    @objc
    public var spacing: CGFloat {
        get {return spec.spacing}
        set {spec.spacing = newValue}
    }
}
