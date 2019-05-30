//
//  CornerLayoutViewController.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/21.
//  Copyright © 2019 zjade. All rights reserved.
//

import UIKit

class CornerLayoutViewController: LayoutViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let corner = CornerLayoutTest()
        corner.test(in: self.view, isUseYoga: false)
        for layout in self.view.layout.childs {
            let layout = layout as! (YogaLayoutable & VirtualLayoutCompatible)
            layout.yoga.margin = 5
            let view = (layout.child as! ViewActualLayout).view as! UIView
            view.backgroundColor = UIColor.red
        }
        self.view.layout
            .container(containerSize: self.view.frame.size)
            .applyLayout(preserveOrigin: false)
        for layout in self.view.layout.childs {
            let layoutView = UIView()
            layoutView.backgroundColor = UIColor.blue
            layoutView.frame = layout.frame
            self.view.insertSubview(layoutView, at: 0)
            print("frame:\(layout.frame)")
        }
    }
}
class CornerLayoutTest: LayoutTest {
    let array: [CornerVirtualLayoutOption] = [
        .topLeft(10, 10),
        .topRight(10, 10),
        .bottomLeft(10, 10),
        .bottomRight(10, 10),
        
        .leftFill(20, 20),
        .rightFill(20, 20),
        .topFill(20, 20),
        .bottomFill(20, 20),
    ]
    func test(in view: UIView, isUseYoga: Bool) {
        view.layout.configureLayout { (node) in
            node.flexDirection = .row
            node.flexWrap = .wrap
            node.justifyContent = .flexStart
        }
        for option in array {
            let itemView = createItem(in: view, itemSize: itemSize)
            let layout = itemView.layout.corner(option, isUseYoga: isUseYoga)
            layout.yoga.height = YGValue(layoutHeight)
            layout.yoga.width = 50%
            layout.yoga.flexGrow = 1
            view.layout.addChild(layout)
        }
    }
}
