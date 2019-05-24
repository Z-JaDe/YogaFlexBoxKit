//
//  LayoutNode.m
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/21.
//  Copyright © 2019 zjade. All rights reserved.
//

#import "LayoutNode.h"

static YGConfigRef globalConfig;
@interface AbstractLayoutNode()

@end
@implementation AbstractLayoutNode

+ (void)initialize {
    globalConfig = YGConfigNew();
    YGConfigSetExperimentalFeatureEnabled(globalConfig, YGExperimentalFeatureWebFlexBasis, true);
    YGConfigSetPointScaleFactor(globalConfig, [UIScreen mainScreen].scale);
}
- (instancetype)initWithTarget:(id)target {
    if (self = [super init]) {
        _target = target;
        _node = YGNodeNewWithConfig(globalConfig);
        YGNodeSetContext(_node, (__bridge void *) target);
    }
    return self;
}
- (void)dealloc {
    YGNodeFree(self.node);
}
#pragma mark -
- (BOOL)isDirty {
    return YGNodeIsDirty(self.node);
}

- (void)markDirty {
    if (self.isDirty) {
        return;
    }
    YGNodeMarkDirty(self.node);
}
#pragma mark -
- (NSUInteger)numberOfChildren {
    return YGNodeGetChildCount(self.node);
}
-(void)removeAllChildren {
    if (self.node == nil) {
        return;
    }
    YGNodeRemoveAllChildren(self.node);
}
-(void)removeChild:(AbstractLayoutNode*)childNode {
    if (self.node == nil || childNode == nil) {
        return;
    }
    YGNodeRemoveChild(self.node, childNode.node);
}
-(void)insertChild:(AbstractLayoutNode*)childNode index:(uint32_t)index {
    YGNodeInsertChild(self.node, childNode.node, index);
}
-(YGNodeRef __nullable)getChild:(uint32_t)index {
    return YGNodeGetChild(self.node, index);
}

#pragma mark -
-(void)setMeasureFunc:(YGMeasureFunc)func {
    YGNodeSetMeasureFunc(self.node, func);
}
@end
