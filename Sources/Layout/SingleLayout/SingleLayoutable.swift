//
//  SingleLayoutable.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public protocol SingleLayoutable: Layoutable {
    var child: Layoutable {get}
}
public extension SingleLayoutable {
    func getFrame() -> CGRect {
        return child.getFrame()
    }
    func calculateLayout(with size: CGSize) -> CGSize {
        return child.calculateLayout(with: size)
    }
    func applyLayout(origin: CGPoint, size: CGSize) {
        child.applyLayout(origin: origin, size: size)
    }
}
