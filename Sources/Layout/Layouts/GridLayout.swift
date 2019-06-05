//
//  GridLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/31.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

///处理指定数量后换行
public class GridLayout: LeafLayout {
    let spec: GridLayoutSpec = GridLayoutSpec()
    #if ObjcSupport
    @objc
    public var itemEqual: GridItemEqual = .allSize {
        didSet { itemEqualChanged() }
    }
    @objc
    public var lineLength: UInt = 0 {
        didSet { spec.invalidateIntrinsicSize() }
    }
    #else
    public var itemEqual: GridItemEqual = .allSize {
        didSet { itemEqualChanged() }
    }
    public var lineLength: UInt = 0 {
        didSet { spec.invalidateIntrinsicSize() }
    }
    #endif
    
    func itemEqualChanged() {
        switch self.itemEqual {
        case .everyLineSizeAndAllHieght, .allSize:
            self.spec.allItemEqual = true
        case .everyLineSize, .none:
            self.spec.allItemEqual = false
        }
        spec.invalidateIntrinsicSize()
    }
    
    public override func configInit() {
        super.configInit()
        self.flexDirection = .row
        itemEqualChanged()
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
