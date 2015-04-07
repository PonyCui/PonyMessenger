//
//  PPMChatManager.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/3.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatMessageManager.h"
#import "PPMApplication.h"
#import "PPMChatSessionItem.h"
#import "PPMChatRecordItem.h"
#import "PPMChatDataManager.h"
#import "PPMUserItem.h"
#import <PonyChatUI/PCUApplication.h>
#import <PonyChatUI/PCUSender.h>
#import <PonyChatUI/PCUMessage.h>

@interface PPMChatMessageManager ()

@property (nonatomic, strong) PPMChatSessionItem *sessionItem;

@end

@implementation PPMChatMessageManager

+ (void)load {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleUIApplicationDidFinishLaunchingNotification)
     name:UIApplicationDidFinishLaunchingNotification
     object:nil];
}

+ (void)handleUIApplicationDidFinishLaunchingNotification {
    [PCUApplication setMessageManagerClass:[PPMChatMessageManager class]];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self connect];
    }
    return self;
}

- (void)connect {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handlePPMChatItemSessionReadyNotification:)
                                                 name:kPPMChatItemSessionReadyNotification
                                               object:nil];
}

- (void)disconnect {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)sendMessage:(PCUMessage *)message {
    PPMChatRecordItem *recordItem = [[PPMChatRecordItem alloc] initWithMessage:message];
    recordItem.sessionID = self.sessionItem.sessionID;
    [[ChatCore dataManager] postWithRecordItem:recordItem completionBlock:^{
        [self.delegate messageManagerDidSentMessage:message];
    } failureBlock:^(NSError *error) {
        [self.delegate messageManagerSendMessageFailed:message error:error];
    }];
    [self.delegate messageManagerDidReceivedMessage:message];
    [self.delegate messageManagerSendMessageStarted:message];
}

- (void)receiveMessageWithRecordItem:(PPMChatRecordItem *)recordItem {
    if ([recordItem isKindOfClass:[PPMChatRecordItem class]]) {
        PCUMessage *message = [[PCUMessage alloc] init];
        message.identifier = recordItem.recordHash;
        message.orderIndex = [recordItem.recordTime unsignedIntegerValue] * 1000;
        message.type = [recordItem.recordType unsignedIntegerValue];
        message.title = recordItem.recordTitle;
        if (recordItem.recordParams != nil && recordItem.recordParams.length) {
            message.params = [NSJSONSerialization
                              JSONObjectWithData:[recordItem.recordParams dataUsingEncoding:NSUTF8StringEncoding]
                              options:kNilOptions
                              error:NULL];
        }
        [[UserCore userManager] fetchUserInformationWithUserID:recordItem.fromUserID forceUpdate:NO completionBlock:^(PPMUserItem *item) {
            message.sender = [[PCUSender alloc] init];
            message.sender.identifier = [item.userID stringValue];
            message.sender.title = item.nickname;
            message.sender.thumbURLString = item.avatarURLString;
            [self.delegate messageManagerDidReceivedMessage:message];
        }];
    }
}

- (void)handlePPMChatItemSessionReadyNotification:(NSNotification *)sender {
    if (sender.object == self.chatItem) {
        self.sessionItem = sender.userInfo[@"sessionItem"];
        [self connectStore];
    }
}

- (void)connectStore {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handlePPMChatRecordDidUpdateNotification:)
                                                 name:kPPMChatRecordDidUpdateNotification
                                               object:nil];
    [[ChatCore dataManager]
     findRecentRecordsWithSessionItem:self.sessionItem
     completionBlock:^(NSArray *items) {
        [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self receiveMessageWithRecordItem:obj];
        }];
    }];
}

- (void)handlePPMChatRecordDidUpdateNotification:(NSNotification *)sender {
    if ([[sender.object sessionID] isEqualToNumber:self.sessionItem.sessionID]) {
        [self receiveMessageWithRecordItem:sender.object];
    }
}

@end
