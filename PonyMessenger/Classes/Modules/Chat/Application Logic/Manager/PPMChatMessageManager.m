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
#import <PonyChatUI/PCUApplication.h>

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
        
    } failureBlock:^(NSError *error) {
        
    }];
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
}

- (void)handlePPMChatRecordDidUpdateNotification:(NSNotification *)sender {
    if ([[sender.object sessionID] isEqualToNumber:self.sessionItem.sessionID]) {
        //Received Message
    }
}

@end
