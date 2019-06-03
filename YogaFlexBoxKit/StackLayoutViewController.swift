//
//  StackLayoutViewController.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

class StackLayoutViewController: LayoutViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let stackLayout = StackLayout()
        stackLayout.spacing = 10
        stackLayout.flexDirection = .column
        stackLayout.distribution = .spaceEvenly
        stackLayout.configureLayout { (yoga) in
            yoga.marginTop = 100
        }
        self.view.layout.addChild(stackLayout)
        for i in 0..<10 {
            let label = UILabel()
            label.backgroundColor = UIColor.red
            label.text = "\(i)adasdasdasda"
            if i == 1 {
                label.layout.yoga.alignSelf = .stretch
            }
            stackLayout.addChild(label.layout)
        }
        self.view.layout
            .container(containerSize: self.view.frame.size)
            .applyLayout()
    }
}
