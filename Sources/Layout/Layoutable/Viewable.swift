//
//  Viewable.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/29.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public protocol Viewable: class {
    var ownerView: UIView {get}
    var superview: UIView? {get}
    func addSubview(_ view: UIView)
    func sizeThatFits(_ size: CGSize) -> CGSize
    func convert(_ point: CGPoint, to view: UIView?) -> CGPoint
}
extension ActualLayout: Viewable {
    public func addSubview(_ view: UIView) {
        self.view?.addSubview(view)
    }
    public var ownerView: UIView {
        return view!.ownerView
    }
    public var superview: UIView? {
        return view!.superview
    }
    public func convert(_ point: CGPoint, to view: UIView?) -> CGPoint {
        return self.view!.convert(point, to: view)
    }
}
extension VirtualLayout: Viewable {
    public var superview: UIView? {
        return child.superview
    }
    public var ownerView: UIView {
        return child.ownerView
    }
    public func addSubview(_ view: UIView) {
        child.addSubview(view)
    }
    public func convert(_ point: CGPoint, to view: UIView?) -> CGPoint {
        return child.convert(point, to: view)
    }
}
