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
    public var flexDirection: GridFlexDirection {
        get {return spec.flexDirection}
        set {spec.flexDirection = newValue}
    }
    public var distribution: GridJustify {
        get {return spec.alignContent}
        set {spec.alignContent = newValue}
    }
    public var spacing: CGFloat {
        get {return spec.spacing}
        set {spec.spacing = newValue}
    }
}
extension StackLayout: LeafLayoutProtocol {
    public func frameDidChanged(oldFrame: CGRect, newFrame: CGRect) {
        updateSpecChild()
        self.spec.setChildFrames(newFrame.bounds)
    }
    public func calculateSize(_ size: CGSize) -> CGSize {
        updateSpecChild()
        return self.spec.intrinsicSize
    }
    func updateSpecChild() {
        if self.hasExactSameChildren(self.spec.childs) {
            return
        }
        self.spec.childs = self.canUseChilds
    }
}
