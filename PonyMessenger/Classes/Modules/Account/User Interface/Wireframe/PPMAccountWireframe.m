//
//  PPMAccountWireframe.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMAccountWireframe.h"
#import "PPMAccountActiveSigninViewController.h"
#import "PPMAccountSigninViewController.h"
#import "PPMApplication.h"

@implementation PPMAccountWireframe

- (void)presentActiveSigninViewControllerToWindow:(UIWindow *)window {
    PPMAccountActiveSigninViewController *activeSigninViewController = [self activeSigninViewController];
    [window setRootViewController:activeSigninViewController];
}

- (void)presentSigninViewControllerToWindow:(UIWindow *)window {
    PPMAccountSigninViewController *signinViewController = [self signinViewController];
    signinViewController.navigationItem.leftBarButtonItem = nil;
    UINavigationController *navigationController = [[[[PPMApplication sharedApplication] core] wireframe] standardNavigationController];
    [navigationController setViewControllers:@[signinViewController] animated:NO];
    [window setRootViewController:navigationController];
}

- (void)presentSigninViewControllerToViewController:(UIViewController *)viewController {
    PPMAccountSigninViewController *signinViewController = [self signinViewController];
    UINavigationController *navigationController = [[[[PPMApplication sharedApplication] core] wireframe] standardNavigationController];
    [navigationController setViewControllers:@[signinViewController] animated:NO];
    [viewController presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - Getter

- (PPMAccountActiveSigninViewController *)activeSigninViewController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"PPMAccount" bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:@"PPMAccountActiveSigninViewController"];
}

- (PPMAccountSigninViewController *)signinViewController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"PPMAccount" bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:@"PPMAccountSigninViewController"];
}

@end
