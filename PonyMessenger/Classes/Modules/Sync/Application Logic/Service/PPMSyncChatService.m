//
//  PPMSyncChatService.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/3.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMSyncChatService.h"
#import "PPMApplication.h"
#import "PPMSyncItem.h"
#import "PPMChatDataManager.h"

@interface PPMSyncChatService ()

@property (nonatomic, strong) PPMSyncItem *sessionsSyncItem;

@property (nonatomic, strong) PPMSyncItem *sessionSyncItem;

@property (nonatomic, strong) PPMSyncItem *recordSyncItem;

@end

@implementation PPMSyncChatService

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureSessions];
        [self configureSession];
        [self configureRecord];
    }
    return self;
}

/**
 *  @brief 全量更新
 */
- (void)configureSessions {
    self.sessionsSyncItem = [[PPMSyncItem alloc] init];
    self.sessionsSyncItem.syncID = @"PPM.Chat.Sessions";
    [self.sessionsSyncItem setSyncingBlock:^(PPMSyncItem *syncItem) {
        [[ChatCore dataManager] updateSessions];
    }];
    [[SyncCore syncManager] addItem:self.sessionsSyncItem];
}

/**
 *  @brief 差量更新
 */
- (void)configureSession {
    self.sessionSyncItem = [[PPMSyncItem alloc] init];
    self.sessionSyncItem.syncID = @"PPM.Chat.Session";
    [self.sessionSyncItem setSyncingBlock:^(PPMSyncItem *syncItem) {
        [[ChatCore dataManager] updateSessionWithETag];
    }];
}

- (void)configureRecord {
    self.recordSyncItem = [[PPMSyncItem alloc] init];
    self.recordSyncItem.syncID = @"PPM.Chat.Record";
    [self.recordSyncItem setSyncingBlock:^(PPMSyncItem *syncItem) {
        [[ChatCore dataManager] updateRecords];
    }];
    [[SyncCore syncManager] addItem:self.recordSyncItem];
}

- (void)didAddSession {
    [self.sessionSyncItem doSync];
}

- (void)didUpdateSession {
    [self.sessionSyncItem doSync];
}

- (void)didAddRecord {
    [self.recordSyncItem doSync];
}

@end
