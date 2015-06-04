//
//  PPMChatWireframe.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PPMChatWireframe : NSObject

- (void)presentRecentViewControllerToTabBarController:(UITabBarController *)tabBarController;

- (void)presentContactViewControllerToTabBarController:(UITabBarController *)tabBarController;

- (void)presentSessionViewControllerToNavigationController:(UINavigationController *)navigationController
                                                  toUserID:(NSNumber *)toUserID
                                              sessionTitle:(NSString *)sessionTitle;

- (void)presentSessionViewControllerToNavigationController:(UINavigationController *)navigationController
                                               toSessionID:(NSNumber *)toSessionID
                                              sessionTitle:(NSString *)sessionTitle;

- (void)presentAddContactViewControllerToNavigationController:(UINavigationController *)navigationController;

@end
