//
//  StackLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public class StackLayout: LeafLayout {
    var spec: StackLayoutSpec = StackLayoutSpec()
    public var flexDirection: GridFlexDirection {
        get {return spec.flexDirection}
        set {spec.flexDirection = newValue}
    }
    public var distribution: GridJustify {
        get {return spec.distribution}
        set {spec.distribution = newValue}
    }
    public var spacing: CGFloat {
        get {return spec.spacing}
        set {spec.spacing = newValue}
    }
    var canUseChilds: [YogaLayoutable] {
        return self.childs.filter({$0.yoga.isIncludedInLayout})
    }
}
extension StackLayout: LeafLayoutProtocol {
    public func frameDidChanged(oldFrame: CGRect, newFrame: CGRect) {
        self.spec.setChildFrames(newFrame, self.canUseChilds)
    }
    public func calculateSize(_ size: CGSize) -> CGSize {
        return self.spec.calculateSize(size, self.canUseChilds)
    }
}
