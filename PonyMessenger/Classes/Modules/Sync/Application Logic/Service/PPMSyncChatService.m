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
#import "PPMChatRecordManager.h"

@interface PPMSyncChatService ()

@property (nonatomic, strong) PPMSyncItem *sessionSyncItem;

@property (nonatomic, strong) PPMSyncItem *recordSyncItem;

@end

@implementation PPMSyncChatService

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureSession];
        [self configureRecord];
    }
    return self;
}

- (void)configureSession {
    self.sessionSyncItem = [[PPMSyncItem alloc] init];
    self.sessionSyncItem.syncID = @"PPM.Chat.Session";
    [self.sessionSyncItem setSyncingBlock:^(PPMSyncItem *syncItem) {
        [[ChatCore recordManager] updateSessions];
    }];
    [[SyncCore syncManager] addItem:self.sessionSyncItem];
}

- (void)configureRecord {
    self.recordSyncItem = [[PPMSyncItem alloc] init];
    self.recordSyncItem.syncID = @"PPM.Chat.Record";
    [self.recordSyncItem setSyncingBlock:^(PPMSyncItem *syncItem) {
        [[ChatCore recordManager] updateRecords];
    }];
    [[SyncCore syncManager] addItem:self.recordSyncItem];
}

- (void)didUpdateSession {
    [self.sessionSyncItem doSync];
}

- (void)didAddRecord {
    [self.recordSyncItem doSync];
}

@end
