//
//  UpdateLayoutProtocol.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/29.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

extension ActualLayout {
    func updateViewFrame(_ frame: CGRect) {
        // 每次重新创建Timer实例，简单测试后发现速度反而慢了
        //        throttle(&layoutViewTimer, interval: .milliseconds(100)) {
        //        }
        guard let view = self.view else {
            assertionFailure("view丢失")
            return
        }
        let frame = CGRect(origin: converToViewHierarchy(frame.origin), size: frame.size)
        if frame.size.isNaNOrMax {
            assertionFailure("计算frame出错")
            return
        }
        if view.frame != frame {
            view.frame = frame
        }
        if let scrollView = view as? UIScrollView {
            let contentSize = self.yoga.contentSize
            if scrollView.contentSize != contentSize {
                scrollView.contentSize = contentSize
            }
        }
    }

    func converToViewHierarchy(_ point: CGPoint) -> CGPoint {
        var point = point
        var superLayout = self.superLayout
        while let layout = superLayout {
            if let superView = (superLayout as? ActualLayout)?.view {
                point = superView.convert(point, to: view?.superview)
                break
            } else {
                point.x += layout.getFrame().origin.x
                point.y += layout.getFrame().origin.y
            }
            superLayout = layout.superLayout
        }
        return point
    }
}
