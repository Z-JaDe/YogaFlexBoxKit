//
//  GridLayout+Extension.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/5.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

#if ObjcSupport

extension GridLayout {
    @objc
    public var flexDirection: GridFlexDirection {
        get {return spec.flexDirection.reversed()}
        set {spec.flexDirection = newValue.reversed()}
    }
    @objc
    public var justifyContent: GridJustify {
        get {return spec.justifyContent}
        set {spec.justifyContent = newValue}
    }
    @objc
    public var alignContent: GridJustify {
        get {return spec.alignContent}
        set {spec.alignContent = newValue}
    }
    @objc
    public var lineSpace: CGFloat {
        get {return spec.lineSpace}
        set {spec.lineSpace = newValue}
    }
    @objc
    public var itemSpace: CGFloat {
        get {return spec.itemSpace}
        set {spec.itemSpace = newValue}
    }
}

#else

extension GridLayout {
    public var flexDirection: GridFlexDirection {
        get {return spec.flexDirection.reversed()}
        set {spec.flexDirection = newValue.reversed()}
    }
    public var justifyContent: GridJustify {
        get {return spec.justifyContent}
        set {spec.justifyContent = newValue}
    }
    public var alignContent: GridJustify {
        get {return spec.alignContent}
        set {spec.alignContent = newValue}
    }
    public var lineSpace: CGFloat {
        get {return spec.lineSpace}
        set {spec.lineSpace = newValue}
    }
    public var itemSpace: CGFloat {
        get {return spec.itemSpace}
        set {spec.itemSpace = newValue}
    }
}

#endif
