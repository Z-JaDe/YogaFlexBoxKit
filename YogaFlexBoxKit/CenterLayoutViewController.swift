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
        corner.test(in: self.view, self.view.frame)
        for layout in self.view.layout.childs {
            let layout = layout as! VirtualLayout
            layout.yoga.margin = 5
            let view = (layout.child as! ActualLayout).view!
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
class CenterLayoutTest: LayoutTest {
    let array: [CenterVirtualLayoutOptions] = [
        .X,
        .Y,
        .XY
    ]
    func test(in view: UIView, _ rect: CGRect) {
        view.layout.containerRect = rect
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
        reload(in: view)
    }

}
