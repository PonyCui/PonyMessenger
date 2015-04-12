//
//  PPMChatSessionInteractor.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatSessionInteractor.h"
#import "PPMApplication.h"
#import "PPMChatDataManager.h"
#import "PPMUserItem.h"
#import <PonyChatUI/PCUChat.h>

@implementation PPMChatSessionInteractor

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handlePPMChatSessionDidUpdateNotification)
                                                     name:kPPMChatSessionDidUpdateNotification
                                                   object:nil];
    }
    return self;
}

- (void)handlePPMChatSessionDidUpdateNotification {
    [self requestSessionItem];
}

- (void)requestSessionItem {
    if (self.sessionItem == nil && [self.chatItem.identifier hasPrefix:@"User."]) {
        NSNumber *userID = [NSNumber numberWithInteger:[[self.chatItem.identifier stringByReplacingOccurrencesOfString:@"User." withString:@""] integerValue]];
        [[UserCore userManager] fetchUserInformationWithUserID:userID forceUpdate:NO completionBlock:^(PPMUserItem *userItem) {
            [[ChatCore dataManager] findSessionWithUserItem:userItem completionBlock:^(PPMChatSessionItem *sessionItem) {
                self.sessionItem = sessionItem;
                self.sessionTitle = userItem.nickname;
                [[NSNotificationCenter defaultCenter] postNotificationName:kPPMChatItemSessionReadyNotification
                                                                    object:self.chatItem
                                                                  userInfo:@{@"sessionItem": self.sessionItem}];
            }];
        }];
    }
}

@end
