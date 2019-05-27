//
//  LayoutViewController.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/27.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

class LayoutViewController: UIViewController {
    
//    override func loadView() {
//        super.loadView()
//        let scrollView = UIScrollView(frame: self.view.bounds)
//        scrollView.clipsToBounds = false
//        scrollView.backgroundColor = UIColor.yellow
////        scrollView.bounds.size.width = 50
////        scrollView.frame.origin.x = 10
////        scrollView.frame.origin.y = 100
//        scrollView.alwaysBounceVertical = true
//        self.view = scrollView
//    }
}

class LayoutTest {
    let itemSize = CGSize(width: 100, height: 100)
    let layoutHeight: CGFloat = 200
    
    func reload(in view: UIView) {
        view.layout.applyLayout(preserveOrigin: true)
    }
    func createItem(in superview: UIView, itemSize: CGSize) -> UIView {
        let view = UIView()
        view.layout.configureLayout { (node) in
            node.width = YGValue(itemSize.width)
            node.height = YGValue(itemSize.height)
        }
        return view
    }
}
