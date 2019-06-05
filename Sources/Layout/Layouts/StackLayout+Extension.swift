//
//  StackLayout+Extension.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/5.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
#if ObjcSupport

extension StackLayout {
    @objc
    public var flexDirection: GridFlexDirection {
        get {return spec.flexDirection}
        set {spec.flexDirection = newValue}
    }
    @objc
    public var distribution: GridJustify {
        get {return spec.alignContent}
        set {spec.alignContent = newValue}
    }
    @objc
    public var spacing: CGFloat {
        get {return spec.spacing}
        set {spec.spacing = newValue}
    }
}

#else

extension StackLayout {
    public var flexDirection: GridFlexDirection {
        get {return spec.flexDirection}
        set {spec.flexDirection = newValue}
    }
    public var distribution: GridJustify {
        get {return spec.alignContent}
        set {spec.alignContent = newValue}
    }
    public var spacing: CGFloat {
        get {return spec.spacing}
        set {spec.spacing = newValue}
    }
}
#endif
