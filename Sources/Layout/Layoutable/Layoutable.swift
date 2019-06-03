//
//  Layoutable.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public protocol Layoutable {
    func getFrame() -> CGRect
    ///计算布局时根据size返回适合的尺寸
    func calculateLayout(with size: CGSize) -> CGSize
    ///更新布局
    func applyLayout(origin: CGPoint, size: CGSize)
}
