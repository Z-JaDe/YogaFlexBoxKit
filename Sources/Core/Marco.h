//
//  Marco.h
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/22.
//  Copyright © 2019 zjade. All rights reserved.
//

#ifndef Marco_h
#define Marco_h

#define YG_PROPERTY(type, lowercased_name, capitalized_name)    \
- (type)lowercased_name                                         \
{                                                               \
return YGNodeStyleGet##capitalized_name(self.node);           \
}                                                               \
\
- (void)set##capitalized_name:(type)lowercased_name             \
{                                                               \
YGNodeStyleSet##capitalized_name(self.node, lowercased_name); \
}

#define YG_VALUE_PROPERTY(lowercased_name, capitalized_name)                       \
- (YGValue)lowercased_name                                                         \
{                                                                                  \
return YGNodeStyleGet##capitalized_name(self.node);                              \
}                                                                                  \
\
- (void)set##capitalized_name:(YGValue)lowercased_name                             \
{                                                                                  \
switch (lowercased_name.unit) {                                                  \
case YGUnitUndefined:                                                         \
YGNodeStyleSet##capitalized_name(self.node, lowercased_name.value);          \
break;                                                                       \
case YGUnitPoint:                                                              \
YGNodeStyleSet##capitalized_name(self.node, lowercased_name.value);          \
break;                                                                       \
case YGUnitPercent:                                                            \
YGNodeStyleSet##capitalized_name##Percent(self.node, lowercased_name.value); \
break;                                                                       \
default:                                                                       \
NSAssert(NO, @"Not implemented");                                            \
}                                                                                \
}

#define YG_AUTO_VALUE_PROPERTY(lowercased_name, capitalized_name)                  \
- (YGValue)lowercased_name                                                         \
{                                                                                  \
return YGNodeStyleGet##capitalized_name(self.node);                              \
}                                                                                  \
\
- (void)set##capitalized_name:(YGValue)lowercased_name                             \
{                                                                                  \
switch (lowercased_name.unit) {                                                  \
case YGUnitPoint:                                                              \
YGNodeStyleSet##capitalized_name(self.node, lowercased_name.value);          \
break;                                                                       \
case YGUnitPercent:                                                            \
YGNodeStyleSet##capitalized_name##Percent(self.node, lowercased_name.value); \
break;                                                                       \
case YGUnitAuto:                                                               \
YGNodeStyleSet##capitalized_name##Auto(self.node);                           \
break;                                                                       \
default:                                                                       \
NSAssert(NO, @"Not implemented");                                            \
}                                                                                \
}

#define YG_EDGE_PROPERTY_GETTER(type, lowercased_name, capitalized_name, property, edge) \
- (type)lowercased_name                                                                  \
{                                                                                        \
return YGNodeStyleGet##property(self.node, edge);                                      \
}

#define YG_EDGE_PROPERTY_SETTER(lowercased_name, capitalized_name, property, edge) \
- (void)set##capitalized_name:(CGFloat)lowercased_name                             \
{                                                                                  \
YGNodeStyleSet##property(self.node, edge, lowercased_name);                      \
}

#define YG_EDGE_PROPERTY(lowercased_name, capitalized_name, property, edge)         \
YG_EDGE_PROPERTY_GETTER(CGFloat, lowercased_name, capitalized_name, property, edge) \
YG_EDGE_PROPERTY_SETTER(lowercased_name, capitalized_name, property, edge)

#define YG_VALUE_EDGE_PROPERTY_SETTER(objc_lowercased_name, objc_capitalized_name, c_name, edge) \
- (void)set##objc_capitalized_name:(YGValue)objc_lowercased_name                                 \
{                                                                                                \
switch (objc_lowercased_name.unit) {                                                           \
case YGUnitUndefined:                                                                        \
YGNodeStyleSet##c_name(self.node, edge, objc_lowercased_name.value);                       \
break;                                                                                     \
case YGUnitPoint:                                                                            \
YGNodeStyleSet##c_name(self.node, edge, objc_lowercased_name.value);                       \
break;                                                                                     \
case YGUnitPercent:                                                                          \
YGNodeStyleSet##c_name##Percent(self.node, edge, objc_lowercased_name.value);              \
break;                                                                                     \
default:                                                                                     \
NSAssert(NO, @"Not implemented");                                                          \
}                                                                                              \
}

#define YG_VALUE_EDGE_PROPERTY(lowercased_name, capitalized_name, property, edge)   \
YG_EDGE_PROPERTY_GETTER(YGValue, lowercased_name, capitalized_name, property, edge) \
YG_VALUE_EDGE_PROPERTY_SETTER(lowercased_name, capitalized_name, property, edge)

#define YG_VALUE_EDGES_PROPERTIES(lowercased_name, capitalized_name)                                                  \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Left, capitalized_name##Left, capitalized_name, YGEdgeLeft)                   \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Top, capitalized_name##Top, capitalized_name, YGEdgeTop)                      \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Right, capitalized_name##Right, capitalized_name, YGEdgeRight)                \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Bottom, capitalized_name##Bottom, capitalized_name, YGEdgeBottom)             \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Start, capitalized_name##Start, capitalized_name, YGEdgeStart)                \
YG_VALUE_EDGE_PROPERTY(lowercased_name##End, capitalized_name##End, capitalized_name, YGEdgeEnd)                      \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Horizontal, capitalized_name##Horizontal, capitalized_name, YGEdgeHorizontal) \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Vertical, capitalized_name##Vertical, capitalized_name, YGEdgeVertical)       \
YG_VALUE_EDGE_PROPERTY(lowercased_name, capitalized_name, capitalized_name, YGEdgeAll)

#endif /* Marco_h */
