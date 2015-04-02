//
//  PPMUserWireframe.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/2.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMUserWireframe.h"
#import "PPMUserInformationViewController.h"

@implementation PPMUserWireframe

- (void)presentUserInformationViewControllerToNavigationController:(UINavigationController *)navigationController
                                                        withUserID:(NSNumber *)userID {
    PPMUserInformationViewController *viewController = [self userInformationViewController];
    [navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Getter

- (PPMUserInformationViewController *)userInformationViewController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"PPMUser" bundle:nil];
    PPMUserInformationViewController *viewController =
    [storyBoard instantiateViewControllerWithIdentifier:@"PPMUserInformationViewController"];
    return viewController;
}

@end
