//
//  LayoutNode+Style.h
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/22.
//  Copyright © 2019 zjade. All rights reserved.
//

#import "LayoutNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface AbstractLayoutNode (Style)
/// 默认 inherit
@property (nonatomic, readwrite, assign) YGDirection direction;
/// 默认 column
@property (nonatomic, readwrite, assign) YGFlexDirection flexDirection;
/// 默认 flexStart :items之间的对应关系主轴
@property (nonatomic, readwrite, assign) YGJustify justifyContent;
/// 默认 flexStart :items多行时 所有items相对于容器 对齐方式
@property (nonatomic, readwrite, assign) YGAlign alignContent;
/// 默认 stretch :水平方向上的 上下对齐方式，垂直方向上的 左右对齐方式
@property (nonatomic, readwrite, assign) YGAlign alignItems;
/// 默认 auto :单个item的对齐方式
@property (nonatomic, readwrite, assign) YGAlign alignSelf;
/// 默认 relative
@property (nonatomic, readwrite, assign) YGPositionType position;
/// 默认 noWrap
@property (nonatomic, readwrite, assign) YGWrap flexWrap;
/// 默认 visible
@property (nonatomic, readwrite, assign) YGOverflow overflow;
/// 默认 flex
@property (nonatomic, readwrite, assign) YGDisplay display;
/// 默认 nan
@property (nonatomic, readwrite, assign) CGFloat flex;
/// 默认 0 :填充剩余空间的比例 0为不可拉伸
@property (nonatomic, readwrite, assign) CGFloat flexGrow;
/// 默认 0 :内容多出容器时，压缩比例，0为不压缩
@property (nonatomic, readwrite, assign) CGFloat flexShrink;
/// 默认 YGValueAuto
@property (nonatomic, readwrite, assign) YGValue flexBasis;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue left;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue top;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue right;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue bottom;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue start;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue end;

/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue marginLeft;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue marginTop;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue marginRight;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue marginBottom;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue marginStart;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue marginEnd;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue marginHorizontal;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue marginVertical;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue margin;

/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue paddingLeft;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue paddingTop;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue paddingRight;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue paddingBottom;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue paddingStart;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue paddingEnd;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue paddingHorizontal;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue paddingVertical;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue padding;

/// 默认 nan
@property (nonatomic, readwrite, assign) CGFloat borderLeftWidth;
/// 默认 nan
@property (nonatomic, readwrite, assign) CGFloat borderTopWidth;
/// 默认 nan
@property (nonatomic, readwrite, assign) CGFloat borderRightWidth;
/// 默认 nan
@property (nonatomic, readwrite, assign) CGFloat borderBottomWidth;
/// 默认 nan
@property (nonatomic, readwrite, assign) CGFloat borderStartWidth;
/// 默认 nan
@property (nonatomic, readwrite, assign) CGFloat borderEndWidth;
/// 默认 nan
@property (nonatomic, readwrite, assign) CGFloat borderWidth;

/// 默认 YGValueAuto
@property (nonatomic, readwrite, assign) YGValue width;
/// 默认 YGValueAuto
@property (nonatomic, readwrite, assign) YGValue height;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue minWidth;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue minHeight;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue maxWidth;
/// 默认 YGValueUndefined
@property (nonatomic, readwrite, assign) YGValue maxHeight;

/// 默认 nan
@property (nonatomic, readwrite, assign) CGFloat aspectRatio;

/// 默认 inherit
@property (nonatomic, readonly, assign) YGDirection resolvedDirection;


@end

NS_ASSUME_NONNULL_END
