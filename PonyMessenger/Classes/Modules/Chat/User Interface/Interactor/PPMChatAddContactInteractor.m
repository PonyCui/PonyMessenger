//
//  PPMChatAddContactInteractor.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/2.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatAddContactInteractor.h"
#import "PPMApplication.h"

@implementation PPMChatAddContactInteractor

- (void)findUsersWithKeyword:(NSString *)keyword {
    self.isRequesting = YES;
    self.error = nil;
    [[UserCore userManager] fetchUserInformationWithKeyword:keyword completionBlock:^(NSArray *items) {
        if ([items count] == 0) {
            self.error = [NSError errorWithDomain:@"PPM.ChatAddContact" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"User not found."}];
        }
        self.userIDS = items;
        self.isRequesting = NO;
    }];
}

@end
