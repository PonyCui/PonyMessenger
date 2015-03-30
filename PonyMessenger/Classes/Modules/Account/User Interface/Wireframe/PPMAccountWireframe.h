//
//  PPMAccountWireframe.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PPMAccountWireframe : NSObject

- (void)presentActiveSigninViewControllerToWindow:(UIWindow *)window;

- (void)presentSigninViewControllerToWindow:(UIWindow *)window;

- (void)presentSigninViewControllerToViewController:(UIViewController *)viewController;

- (void)presentSignupViewControllerToNavigationController:(UINavigationController *)navigationController;

@end
