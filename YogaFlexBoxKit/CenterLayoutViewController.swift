//
//  CenterLayoutViewController.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/27.
//  Copyright © 2019 zjade. All rights reserved.
//

import UIKit

class CenterLayoutViewController: LayoutViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let corner = CenterLayoutTest()
        corner.test(in: self.view)
        for layout in self.view.layout.childs {
            let layout = layout as! (YogaLayoutable & VirtualLayout)
            layout.yoga.margin = 5
            let view = (layout.child as! ViewActualLayout).view as! UIView
            view.backgroundColor = UIColor.red
        }
        
        self.view.layout
            .corner(.bottomFill(100, 10))
            .corner(.topFill(50, 50))
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
class CenterLayoutTest: LayoutTest {
    let array: [CenterLayoutOption] = [
        .X,
        .Y,
        .XY
    ]
    func test(in view: UIView) {
        view.layout.configureLayout { (node) in
            node.flexWrap = .wrap
            node.flexDirection = .row
            node.justifyContent = .flexStart
        }
        for option in array {
            let itemView = createItem(in: view, itemSize: itemSize)
            let layout = itemView.layout.center(option)
            layout.yoga.height = YGValue(layoutHeight)
            layout.yoga.width = 90%
            view.layout.addChild(layout)
        }
    }

}
