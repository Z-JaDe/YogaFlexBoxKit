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
        corner.test(in: self.view)
        for layout in self.view.childs {
            let layout = layout as! (YogaLayoutable & VirtualLayout)
            layout.yoga.margin = 5
            let view = layout.child as! UIView
            view.backgroundColor = UIColor.red
        }
        self.view
            .corner(.topFill(50, 50))
            .corner(.bottomFill(100, 10))
            .container(containerSize: self.view.frame.size)
            .applyLayout(preserveOrigin: false)
        for layout in self.view.childs {
            let layoutView = UIView()
            layoutView.backgroundColor = UIColor.blue
            layoutView.frame = layout.getFrame()
            self.view.insertSubview(layoutView, at: 0)
            print("frame:\(layout.getFrame())")
        }
    }
}
class CornerLayoutTest: LayoutTest {
    let array: [CornerLayoutOption] = [
        .topLeft(10, 10),
        .topRight(10, 10),
        .bottomLeft(10, 10),
        .bottomRight(10, 10),
        
        .leftFill(20, 20),
        .rightFill(20, 20),
        .topFill(20, 20),
        .bottomFill(20, 20),
    ]
    func test(in view: UIView) {
        view.configureLayout { (node) in
            node.flexDirection = .row
            node.flexWrap = .wrap
            node.justifyContent = .flexStart
        }
        for option in array {
            let itemView = createItem(in: view, itemSize: itemSize)
            let layout = itemView.corner(option)
            layout.yoga.height = YGValue(layoutHeight)
            layout.yoga.width = 50%
            layout.yoga.flexGrow = 1
            view.addChild(layout)
        }
    }
}
