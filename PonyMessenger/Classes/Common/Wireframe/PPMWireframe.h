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

@end