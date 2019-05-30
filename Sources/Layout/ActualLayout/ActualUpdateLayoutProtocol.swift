//
//  ActualUpdateLayoutProtocol.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/29.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

protocol ActualUpdateLayoutProtocol {
    func updateViewFrame(_ frame: CGRect)
}
extension ActualLayout: ActualUpdateLayoutProtocol {
    func updateViewFrame(_ frame: CGRect) {
        ///每次重新创建Timer实例，简单测试后发现速度反而慢了
        //        throttle(&layoutViewTimer, interval: .milliseconds(100)) {
        //        }
        if let layout = self.view as? RenderLayout {
            layout.frame = frame
            return
        }
        let frame = self.converToViewHierarchy(frame)
        if let scrollView = self.view as? UIScrollView {
            var finalFrame = CGRect(origin: frame.origin, size: self.containerSize)
            if finalFrame.size.height.isNaN {
                finalFrame.size.height = frame.size.height
            }
            if finalFrame.size.width.isNaN {
                finalFrame.size.width = frame.size.width
            }
            if scrollView.frame != finalFrame {
                scrollView.frame = finalFrame
            }
            if scrollView.contentSize != frame.size {
                scrollView.contentSize = frame.size
            }
        } else {
            if frame.size.isNaN {
                assertionFailure("计算frame出错")
                return
            }
            if self.view!.frame != frame {
                self.view!.frame = frame
            }
        }
    }

    func converToViewHierarchy(_ rect: CGRect) -> CGRect {
        var frame = rect
        var superLayout = self.superLayout
        while let layout = superLayout {
            if let superView = (superLayout as? ActualLayoutCompatible)?.view {
                frame = superView.convert(frame, to: view?.superview)
                break
            } else {                
                frame.origin.x += layout.frame.origin.x
                frame.origin.y += layout.frame.origin.y
            }
            superLayout = layout.superLayout
        }
        return frame
    }
}
