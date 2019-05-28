//
//  LayoutNode.h
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/21.
//  Copyright © 2019 zjade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <yoga/Yoga.h>

NS_ASSUME_NONNULL_BEGIN

id NodeGetContext(YGNodeRef __nullable node);

@interface AbstractLayoutNode : NSObject
- (instancetype)init
__attribute__((unavailable("you are not meant to initialise YGLayout")));
+ (instancetype)new
__attribute__((unavailable("you are not meant to initialise YGLayout")));

@property (nonatomic, assign, readonly) YGNodeRef node;

@property (nonatomic, readonly, weak) id target;
- (instancetype)initWithTarget:(id)target;

@property (nonatomic, readonly, assign) BOOL isDirty;
- (void)markDirty;

@property (nonatomic, readonly, assign) NSUInteger numberOfChildren;
-(void)removeAllChildren;
-(void)removeChild:(AbstractLayoutNode*)childNode;
-(void)insertChild:(AbstractLayoutNode*)childNode index:(uint32_t)index;
-(YGNodeRef __nullable)getChild:(uint32_t)index;

-(void)setMeasureFunc:(YGMeasureFunc __nullable)func;
@end

NS_ASSUME_NONNULL_END
