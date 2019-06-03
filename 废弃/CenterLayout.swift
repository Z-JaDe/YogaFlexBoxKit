//
//  CenterLayout.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

struct CenterLayout {
    public let child: Layoutable
    public let option: CenterLayoutOption
    init(child: Layoutable, option: CenterLayoutOption) {
        self.child = child
        self.option = option
    }
}
extension CenterLayout: EdgeSingleLayoutable {
    var edgesInset: UIEdgeInsets {
        return .zero
    }
    func layoutChildOrigin(_ newFrame: CGRect, _ size: CGSize) -> CGPoint {
        switch option {
        case .X:
            return CGPoint(
                x: (newFrame.size.width - size.width) / 2,
                y: 0
            )
        case .Y:
            return CGPoint(
                x: 0,
                y: (newFrame.size.height - size.height) / 2
            )
        case .XY:
            return CGPoint(
                x: (newFrame.size.width - size.width) / 2,
                y: (newFrame.size.height - size.height) / 2
            )
        }
    }
}
