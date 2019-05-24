//
//  ViewController.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/21.
//  Copyright © 2019 zjade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layout.configureLayout { (node) in
            node.width = .init(self.view.frame.size.width)
            node.height = .init(self.view.frame.size.height)
        }
        let array: [CornerLayoutOptions] = [
            .leftFill(20, 20),
            .rightFill(20, 20),
            .topFill(20, 20),
            .bottomFill(20, 20),
        ]
        for item in array {
            let view = UIView()
            view.backgroundColor = UIColor.red
            view.layout.configureLayout { (node) in
                node.width = 100
                node.height = 100
            }
            self.view.addSubview(view)
            self.view.layout.addChild(view.layout.corner(item))
        }
        
        self.view.layout.applyLayout(preserveOrigin: false)
        for layout in self.view.layout.childs {
            print("frame:\(layout.frame)")
        }
    }
}

