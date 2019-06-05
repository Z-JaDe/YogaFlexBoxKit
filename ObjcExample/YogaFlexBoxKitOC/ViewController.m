//
//  ViewController.m
//  YogaFlexBoxKitOC
//
//  Created by Apple on 2019/6/5.
//  Copyright © 2019 zjade. All rights reserved.
//

#import "ViewController.h"
#import <YogaFlexBoxKit/YogaFlexBoxKit-Swift.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    StackLayout* layout = [StackLayout new];
//    layout.distribution = GridJustifySpaceAround;
//    layout.spacing = 1;
    GridLayout* layout = [GridLayout new];
    [self.view addChildLayout:layout];
}


@end
