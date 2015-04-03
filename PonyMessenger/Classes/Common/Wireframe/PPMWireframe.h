//
//  PPMWireframe.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PPMWireframe : NSObject

- (void)presentViewController:(UIViewController *)viewController
           toTabBarController:(UITabBarController *)tabBarController;

- (void)showLoadingHUDToViewController:(UIViewController *)viewController
                       timeoutInterval:(NSTimeInterval)timeoutInterval
                  allowUserInteraction:(BOOL)allowUserInteraction;

- (void)hideLoadingHUD;

- (void)showSucceedHUDToViewController:(UIViewController *)viewController description:(NSString *)description;

- (void)showErrorHUDToViewController:(UIViewController *)viewController
                    errorDescription:(NSString *)errorDescription;

- (UINavigationController *)standardNavigationController;

- (UITabBarController *)standardTabBarController;

@end
