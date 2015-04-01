//
//  PPMSyncUserService.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMSyncUserService.h"
#import "PPMApplication.h"
#import "PPMSyncItem.h"

@interface PPMSyncUserService ()

@property (nonatomic, strong) PPMSyncItem *relationSyncItem;

@end

@implementation PPMSyncUserService

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureRelation];
    }
    return self;
}

- (void)configureRelation {
    self.relationSyncItem = [[PPMSyncItem alloc] init];
    self.relationSyncItem.syncID = @"PPM.User.Relation";
    [self.relationSyncItem setSyncingBlock:^(PPMSyncItem *syncItem) {
        
    }];
    [[SyncCore syncManager] addItem:self.relationSyncItem];
}

- (void)didChangeRelation {
    [self.relationSyncItem doSync];
}

@end
