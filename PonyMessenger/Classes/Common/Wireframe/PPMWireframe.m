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
#import <MBProgressHUD/MBProgressHUD.h>

@interface PPMWireframe ()

@property (nonatomic, strong) MBProgressHUD *HUD;

@end

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

- (void)showLoadingHUDToViewController:(UIViewController *)viewController
                       timeoutInterval:(NSTimeInterval)timeoutInterval
                  allowUserInteraction:(BOOL)allowUserInteraction{
    [self.HUD hide:NO];
    self.HUD = [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
    self.HUD.userInteractionEnabled = !allowUserInteraction;
    [self.HUD hide:YES afterDelay:timeoutInterval];
}

- (void)hideLoading {
    [self.HUD hide:YES];
}

- (void)showSucceedHUDToViewController:(UIViewController *)viewController description:(NSString *)description {
    [self.HUD hide:NO];
    self.HUD = [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
    [self.HUD setMode:MBProgressHUDModeCustomView];
    [self.HUD setCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TipViewIcon"]]];
    [self.HUD setLabelText:description];
    [self.HUD hide:YES afterDelay:1.5];
}

- (void)showErrorHUDToViewController:(UIViewController *)viewController
                    errorDescription:(NSString *)errorDescription {
    [self.HUD hide:NO];
    self.HUD = [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
    [self.HUD setMode:MBProgressHUDModeCustomView];
    [self.HUD setCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TipViewIconError"]]];
    [self.HUD setLabelText:errorDescription];
    [self.HUD hide:YES afterDelay:1.5];
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
