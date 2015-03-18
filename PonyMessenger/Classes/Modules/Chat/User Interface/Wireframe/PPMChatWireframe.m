//
//  PPMChatWireframe.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatWireframe.h"
#import "PPMChatRecentViewController.h"
#import "PPMChatContactViewController.h"
#import "PPMApplication.h"

@implementation PPMChatWireframe

- (void)presentRecentViewControllerToTabBarController:(UITabBarController *)tabBarController {
    PPMChatRecentViewController *recentViewController = [self recentViewController];
    [[[[PPMApplication sharedApplication] core] wireframe]
     presentViewController:recentViewController toTabBarController:tabBarController];
}

- (void)presentContactViewControllerToTabBarController:(UITabBarController *)tabBarController {
    PPMChatContactViewController *contactViewController = [self contactViewController];
    [[[[PPMApplication sharedApplication] core] wireframe]
     presentViewController:contactViewController toTabBarController:tabBarController];
}

#pragma mark - Getter

- (PPMChatRecentViewController *)recentViewController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"PPMChat" bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:@"PPMChatRecentViewController"];
}

- (PPMChatContactViewController *)contactViewController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"PPMChat" bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:@"PPMChatContactViewController"];
}

@end
