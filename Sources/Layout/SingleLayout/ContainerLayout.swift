//
//  ContainerLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

struct ContainerLayout {
    let child: Layoutable
    let containerSize: CGSize
    init(child: Layoutable, containerSize: CGSize?) {
        self.child = child
        self.containerSize = containerSize ?? .nan
    }
}
extension ContainerLayout: SingleLayoutable {
    func calculateLayout(with size: CGSize) -> CGSize {
        if containerSize.width.isNaNOrMax && containerSize.height.isNaNOrMax {
            return child.calculateLayout(with: adjustSize(size))
        } else {
            return containerSize
        }
    }
    func applyLayout(origin: CGPoint, size: CGSize) {
        child.applyLayout(origin: origin, size: adjustSize(size))
    }
    func adjustSize(_ size: CGSize) -> CGSize {
        var size: CGSize = size
        if size.width.isNaNOrMax {
            size.width = containerSize.width
        }
        if size.height.isNaNOrMax {
            size.height = containerSize.height
        }
        return size
    }
}
