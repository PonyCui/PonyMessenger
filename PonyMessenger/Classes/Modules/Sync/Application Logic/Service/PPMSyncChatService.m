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

@property (nonatomic, strong) PPMSyncItem *recordSyncItem;

@end

@implementation PPMSyncChatService

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureRecord];
    }
    return self;
}

- (void)configureRecord {
    self.recordSyncItem = [[PPMSyncItem alloc] init];
    self.recordSyncItem.syncID = @"PPM.Chat.Record";
    [self.recordSyncItem setSyncingBlock:^(PPMSyncItem *syncItem) {
        [[ChatCore recordManager] updateRecords];
    }];
    [[SyncCore syncManager] addItem:self.recordSyncItem];
}

- (void)didAddRecord {
    [self.recordSyncItem doSync];
}

@end
