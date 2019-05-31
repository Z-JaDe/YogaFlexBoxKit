//
//  Viewable.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/29.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public protocol Viewable: class {
    var frame: CGRect {get set}
    var ownerView: UIView {get}
    var superview: UIView? {get}
    func addSubview(_ view: UIView)
    func sizeThatFits(_ size: CGSize) -> CGSize
    func convert(_ point: CGPoint, to view: UIView?) -> CGPoint
}
public extension Viewable {
    var size: CGSize {
        return frame.size
    }
}
extension ActualLayout: Viewable {
    func addSubview(_ view: UIView) {
        view.addSubview(view)
    }
    var ownerView: UIView {
        return view!.ownerView
    }
    var superview: UIView? {
        return view?.superview
    }
    func convert(_ point: CGPoint, to view: UIView?) -> CGPoint {
        return view!.convert(point, to: view)
    }
}
extension VirtualLayout: Viewable {
    var superview: UIView? {
        return child.superview
    }
    var ownerView: UIView {
        return child.ownerView
    }
    func addSubview(_ view: UIView) {
        child.addSubview(view)
    }
    func convert(_ point: CGPoint, to view: UIView?) -> CGPoint {
        return child.convert(point, to: view)
    }
}
