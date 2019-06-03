//
//  GridLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/31.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
public enum GridJustify {
    case flexStart
    case flexEnd
    case center

    case spaceBetween
    case spaceAround
    case spaceEvenly
    
    case fill
    case fillEqually
    
    var isFillEqual: Bool {
        return self == .fillEqually
    }
}
///处理指定数量后换行
public class GridLayout: LeafLayout {
    public var flexDirection: YGFlexDirection {
        get { return yoga.flexDirection }
        set { yoga.flexDirection = newValue }
    }
    public var justifyContent: GridJustify = .fill {
        didSet { makeDirty() }
    }
    public var alignContent: GridJustify = .flexStart {
        didSet { makeDirty() }
    }
    public var rowSpace: CGFloat = 0 {
        didSet { makeDirty() }
    }
    public var itemSpace: CGFloat = 0 {
        didSet { makeDirty() }
    }
    public var columnNum: UInt = 0 {
        didSet { makeDirty() }
    }
    let layout: PlaceholderLayout = PlaceholderLayout()
    public override func configInit() {
        super.configInit()
        self.flexDirection = .row
    }
    var gridChilds: AnySequence<ArraySlice<YogaLayoutable>> {
        return self.childs.lazy
            .filter({$0.yoga.isIncludedInLayout})
            .chunk(self.columnNum)
    }

}
extension GridLayout {
    func update() {
        guard self.isLoad else { return }
        makeDirty()
        self.layout.frame = self.frame
    }
}
extension GridLayout: LeafLayoutProtocol {
    public func frameDidChanged(oldFrame: CGRect, newFrame: CGRect) {
        let childs = self.layout.childs.flatMap({$0.childs})
        if self.hasExactSameChildren(childs) {
            self.layout.childs.forEach({
                ($0 as? PlaceholderLayout)?.removeAllChild()
                layout.removeChild($0)
            })
            self.gridChilds.forEach { (childs) in
                let layout = PlaceholderLayout()
                childs.forEach({ layout.addChild($0) })
                self.layout.addChild(layout)
            }
        }
        self.layout.frame = self.frame
    }
    public func calculateSize(_ size: CGSize) -> CGSize {
        return self.layout.calculateLayout(with: size)
    }
}
