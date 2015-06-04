//
//  PPMChatRecentCellInteractor.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatRecentCellInteractor.h"
#import "PPMChatSessionItem.h"
#import "PPMApplication.h"
#import "PPMPrivateCoreData.h"
#import "PPMAccountItem.h"
#import "PPMManagedChatSessionUserItem.h"
#import "PPMUserItem.h"

@interface PPMChatRecentCellInteractor ()

@property (nonatomic, strong) PPMChatSessionItem *sessionItem;

@end

@implementation PPMChatRecentCellInteractor

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nickname = [NSString stringWithFormat:@"PonyCui的小号 - %u", arc4random()];
        self.recentTalk = @"春哥你这个逗逼";
        self.recentDate = [NSDate dateWithTimeIntervalSinceNow:-(arc4random() % 8640000)];
        [NSURLConnection
         sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://pic3.zhimg.com/5f89bb81b3ca4610e568eca5835ac8da_l.jpg"]]
         queue:[NSOperationQueue mainQueue]
         completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            self.iconImage = [UIImage imageWithData:data];
        }];
    }
    return self;
}

- (instancetype)initWithSessionItem:(PPMChatSessionItem *)sessionItem {
    self = [super init];
    if (self && [sessionItem isKindOfClass:[PPMChatSessionItem class]]) {
        self.sessionItem = sessionItem;
        [self configureData];
    }
    return self;
}

- (void)configureData {
    if ([self.sessionItem.sessionType unsignedIntegerValue] == PPMChatSessionTypePerson) {
        [self configurePersonData];
    }
    else if ([self.sessionItem.sessionType unsignedIntegerValue] == PPMChatSessionTypeGroup) {
        [self configureGroupData];
    }
    self.sessionID = self.sessionItem.sessionID;
    self.recentTalk = self.sessionItem.sessionLastPost;
    self.recentDate = [NSDate dateWithTimeIntervalSince1970:[self.sessionItem.sessionLastUpdate integerValue]];
}

- (void)configurePersonData {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"session_id = %@ AND user_id != %@",
                              self.sessionItem.sessionID,
                              [AccountCore accountManager].activeAccount.userID];
    [UserStore fetchChatSessionUserWithPredicate:predicate completionBlock:^(NSArray *results) {
        if ([results count] > 0) {
            PPMManagedChatSessionUserItem *managedSessionUserItem = [results firstObject];
            [[UserCore userManager] fetchUserInformationWithUserID:managedSessionUserItem.user_id forceUpdate:NO completionBlock:^(PPMUserItem *item) {
                self.nickname = item.nickname;
                [NSURLConnection
                 sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:item.avatarURLString]]
                 queue:[NSOperationQueue mainQueue]
                 completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                     self.iconImage = [UIImage imageWithData:data];
                 }];
            }];
        }
    }];
}

- (void)configureGroupData {
    
}

@end
