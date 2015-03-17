//
//  PPMChatRecentViewController.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatRecentViewController.h"

@interface PPMChatRecentViewController ()

@end

@implementation PPMChatRecentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parentViewController.title = @"微信";
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_mainframeHL"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
