//
//  PPMChatWireframe.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatWireframe.h"
#import "PPMChatRecentViewController.h"
#import "PPMChatRecentListPresenter.h"
#import "PPMChatContactViewController.h"
#import "PPMChatSessionViewController.h"
#import "PPMChatSessionPresenter.h"
#import "PPMChatSessionInteractor.h"
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

- (void)presentSessionViewControllerToNavigationController:(UINavigationController *)navigationController
                                              withChatItem:(PCUChat *)chatItem {
    PPMChatSessionViewController *sessionViewController = [self sessionViewController];
    sessionViewController.eventHandler.sessionInteractor.chatItem = chatItem;
    [navigationController pushViewController:sessionViewController animated:YES];
}

#pragma mark - Getter

- (PPMChatRecentViewController *)recentViewController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"PPMChat" bundle:nil];
    PPMChatRecentViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:@"PPMChatRecentViewController"];
    viewController.eventHandler = [[PPMChatRecentListPresenter alloc] init];
    viewController.eventHandler.userInterface = viewController;
    return viewController;
}

- (PPMChatContactViewController *)contactViewController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"PPMChat" bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:@"PPMChatContactViewController"];
}

- (PPMChatSessionViewController *)sessionViewController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"PPMChat" bundle:nil];
    PPMChatSessionViewController *sessionViewController =
    [storyBoard instantiateViewControllerWithIdentifier:@"PPMChatSessionViewController"];
    sessionViewController.eventHandler = [[PPMChatSessionPresenter alloc] init];
    sessionViewController.eventHandler.userInterface = sessionViewController;
    return sessionViewController;
}

@end
