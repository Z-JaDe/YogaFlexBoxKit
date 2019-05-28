//
//  LayoutViewController.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/27.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

class LayoutViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        let scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.clipsToBounds = false
        scrollView.backgroundColor = UIColor.yellow
//        scrollView.bounds.size.width = 50
//        scrollView.frame.origin.x = 10
//        scrollView.frame.origin.y = 100
        scrollView.alwaysBounceVertical = true
        self.view = scrollView
    }

}

class LayoutTest {
    let itemSize = CGSize(width: 50, height: 50)
    let layoutHeight: CGFloat = 200
    
    func reload(in view: UIView) {
        view.layout.applyLayout(preserveOrigin: true)
    }
    func createItem(in superview: UIView, itemSize: CGSize) -> UIView {
        let view = UILabel()
//        view.text = "aasdasdasdasdasdsa"
        view.layout.configureLayout { (node) in
            node.minWidth = YGValue(itemSize.width)
            node.minHeight = YGValue(itemSize.height)
        }
        return view
    }
}
