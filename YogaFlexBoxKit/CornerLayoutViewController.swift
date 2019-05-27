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
        corner.test(in: self.view, self.view.frame)
        for layout in self.view.layout.childs {
            let layout = layout as! SingleLayout
            layout.yoga.margin = 5
            let view = (layout.child as! WrapLayout).view!
            view.backgroundColor = UIColor.red
        }
        corner.reload(in: self.view)
        corner.reload(in: self.view)
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
    let array: [CornerLayoutOptions] = [
        .leftFill(20, 20),
        .rightFill(20, 20),
        .topFill(20, 20),
        .bottomFill(20, 20),
        
        .topLeft(10, 10),
        .topRight(10, 10),
        .bottomLeft(10, 10),
        .bottomRight(10, 10),
    ]
    func test(in view: UIView, _ rect: CGRect) {
        view.layout.containerRect = rect
        view.layout.configureLayout { (node) in
            node.flexDirection = .row
            node.flexWrap = .wrap
            node.justifyContent = .flexStart
        }
        for option in array {
            let itemView = createItem(in: view, itemSize: itemSize)
            let layout = itemView.layout.corner(option)
            layout.yoga.height = YGValue(layoutHeight)
            layout.yoga.width = 40%
            view.layout.addChild(layout)
        }
        reload(in: view)
    }
}
