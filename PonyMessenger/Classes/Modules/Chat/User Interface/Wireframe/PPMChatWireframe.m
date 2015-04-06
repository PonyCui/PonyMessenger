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
#import "PPMChatContactListPresenter.h"
#import "PPMChatSessionViewController.h"
#import "PPMChatSessionPresenter.h"
#import "PPMChatSessionInteractor.h"
#import "PPMChatAddContactViewController.h"
#import "PPMChatAddContactPresenter.h"
#import <PonyChatUI/PCUChat.h>
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
                                                  toUserID:(NSNumber *)toUserID {
    PPMChatSessionViewController *sessionViewController = [self sessionViewController];
    PCUChat *chatItem = [[PCUChat alloc] init];
    chatItem.identifier = [NSString stringWithFormat:@"User.%@", toUserID];
    sessionViewController.eventHandler.sessionInteractor.chatItem = chatItem;
    [navigationController pushViewController:sessionViewController animated:YES];
}

- (void)presentAddContactViewControllerToNavigationController:(UINavigationController *)navigationController {
    PPMChatAddContactViewController *addContactViewController = [self addContactViewController];
    [navigationController pushViewController:addContactViewController animated:YES];
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
    PPMChatContactViewController *viewController =
    [storyBoard instantiateViewControllerWithIdentifier:@"PPMChatContactViewController"];
    viewController.eventHandler = [[PPMChatContactListPresenter alloc] init];
    viewController.eventHandler.userInterface = viewController;
    return viewController;
}

- (PPMChatSessionViewController *)sessionViewController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"PPMChat" bundle:nil];
    PPMChatSessionViewController *sessionViewController =
    [storyBoard instantiateViewControllerWithIdentifier:@"PPMChatSessionViewController"];
    sessionViewController.eventHandler = [[PPMChatSessionPresenter alloc] init];
    sessionViewController.eventHandler.userInterface = sessionViewController;
    return sessionViewController;
}

- (PPMChatAddContactViewController *)addContactViewController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"PPMChat" bundle:nil];
    PPMChatAddContactViewController *viewController =
    [storyBoard instantiateViewControllerWithIdentifier:@"PPMChatAddContactViewController"];
    viewController.eventHandler = [[PPMChatAddContactPresenter alloc] init];
    viewController.eventHandler.userInterface = viewController;
    return viewController;
}

@end
