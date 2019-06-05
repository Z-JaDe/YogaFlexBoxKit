//
//  GridLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/31.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public enum GridItemEqual {
    ///每个item默认使用自有尺寸, 根据情况缩放
    case none
    ///每一行每个item尺寸相等, 多行之间的item不一定相等
    case everyLineSize
    ///每一行每个item尺寸相等, 多行之间item只有高度相等
    case everyLineSizeAndAllHieght
    ///每个item之间尺寸相等
    case allSize
}
///处理指定数量后换行
public class GridLayout: LeafLayout {
    let spec: GridLayoutSpec = GridLayoutSpec()
    public var flexDirection: GridFlexDirection {
        get {return spec.flexDirection.reversed()}
        set {spec.flexDirection = newValue.reversed()}
    }
    public var justifyContent: GridJustify {
        get {return spec.justifyContent}
        set {spec.justifyContent = newValue}
    }
    public var alignContent: GridJustify {
        get {return spec.alignContent}
        set {spec.alignContent = newValue}
    }
    public var lineSpace: CGFloat {
        get {return spec.lineSpace}
        set {spec.lineSpace = newValue}
    }
    public var itemEqual: GridItemEqual = .allSize {
        didSet {
            switch self.itemEqual {
            case .everyLineSizeAndAllHieght, .allSize:
                self.spec.allItemEqual = true
            case .everyLineSize, .none:
                self.spec.allItemEqual = false
            }
            spec.invalidateIntrinsicSize()
        }
    }
    
    public var itemSpace: CGFloat {
        get {return spec.itemSpace}
        set {spec.itemSpace = newValue}
    }
    public var lineLength: UInt = 0 {
        didSet { spec.invalidateIntrinsicSize() }
    }
    
    public override func configInit() {
        super.configInit()
        self.flexDirection = .row
        self.itemEqual = .allSize
    }
    
}
extension GridLayout: LeafLayoutProtocol {
    public func frameDidChanged(oldFrame: CGRect, newFrame: CGRect) {
        updateSpecChild()
        self.spec.setChildFrames(newFrame.bounds, self.itemEqual, Int(self.lineLength))
    }
    public func calculateSize(_ size: CGSize) -> CGSize {
        updateSpecChild()
        return self.spec.intrinsicSize
    }
    
    var gridChilds: AnySequence<ArraySlice<YogaLayoutable>> {
        return childs.lazy
            .filter({$0.yoga.isIncludedInLayout})
            .chunk(self.lineLength)
    }
    func updateSpecChild() {
        let specChild = self.spec.childs.lazy.flatMap({$0.childs})
        if self.hasExactSameChildren(specChild) {
            let lineLength: Int = self.lineLength > 0 ? Int(self.lineLength) : self.childs.count
            let specLineLength = self.spec.childs.first?.childs.count ?? 0
            if specLineLength == lineLength {
                return
            }
        }
        for (offset, child) in gridChilds.enumerated() {
            let stackSpec: StackLayoutSpec
            if offset < self.spec.childs.count {
                stackSpec = self.spec.childs[offset]
            } else {
                stackSpec = StackLayoutSpec()
                self.spec.childs.append(stackSpec)
            }
            stackSpec.alignContent = self.justifyContent
            stackSpec.spacing = self.itemSpace
            stackSpec.flexDirection = self.flexDirection
            switch self.itemEqual {
            case .everyLineSize, .everyLineSizeAndAllHieght, .allSize:
                stackSpec.allItemEqual = true
            case .none:
                stackSpec.allItemEqual = false
            }
            stackSpec.childs = Array(child)
        }
    }
}
