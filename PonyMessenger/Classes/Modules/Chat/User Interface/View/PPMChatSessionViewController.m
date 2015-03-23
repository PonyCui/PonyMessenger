//
//  PPMChatSessionViewController.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatSessionViewController.h"
#import "PPMChatSessionPresenter.h"

@interface PPMChatSessionViewController ()

@end

@implementation PPMChatSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.eventHandler updateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
