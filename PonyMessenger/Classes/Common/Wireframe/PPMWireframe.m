//
//  PPMWireframe.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMWireframe.h"
#import "PPMNavigationController.h"
#import "PPMTabBarController.h"

@implementation PPMWireframe

- (void)presentViewController:(UIViewController *)viewController
           toTabBarController:(UITabBarController *)tabBarController {
    NSMutableArray *viewControllers = [[tabBarController viewControllers] mutableCopy];
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [viewControllers addObject:viewController];
    }
    else {
        PPMNavigationController *navigationController = [self navigationController];
        [navigationController setViewControllers:@[viewController]];
        [viewControllers addObject:navigationController];
    }
    [tabBarController setViewControllers:[viewControllers copy]];
}

- (UINavigationController *)standardNavigationController {
    return [self navigationController];
}

- (UITabBarController *)standardTabBarController {
    return [self tabBarController];
}

#pragma mark - Getter

- (PPMNavigationController *)navigationController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:@"PPMNavigationController"];
}

- (PPMTabBarController *)tabBarController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:@"PPMTabBarController"];
}

@end
