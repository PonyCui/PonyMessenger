//
//  PPMTabBarController.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMTabBarController.h"

@interface PPMTabBarController ()

@end

@implementation PPMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tabBar setSelectedImageTintColor:[UIColor colorWithRed:31.0/255.0
                                                           green:185.0/255.0
                                                            blue:34.0/255.0
                                                           alpha:1.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
