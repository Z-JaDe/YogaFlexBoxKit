//
//  GridLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/31.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public class GridLayout: RenderLayout {
    public var columnNum: UInt = 0 {
        didSet { updateYogaLayoutConfig() }
    }
    
    public override func configInit() {
        super.configInit()
        changeFlexIfZero(1)
        updateYogaLayoutConfig()
    }
    var gridChilds: AnySequence<ArraySlice<YogaLayoutable>> {
        return self.childs.chunk(self.columnNum)
    }

    func updateYogaLayoutConfig() {
        
    }
}
