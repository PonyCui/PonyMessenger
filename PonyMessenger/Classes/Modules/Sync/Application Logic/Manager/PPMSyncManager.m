//
//  PPMSyncManager.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMSyncManager.h"
#import "PPMSyncItem.h"

@interface PPMSyncManager ()

@property (nonatomic, copy) NSDictionary *syncItems;

@end

@implementation PPMSyncManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _syncItems = @{};
    }
    return self;
}

- (void)addItem:(PPMSyncItem *)item {
    NSMutableDictionary *syncItems = [self.syncItems mutableCopy];
    [syncItems setObject:item forKey:item.syncID];
    self.syncItems = syncItems;
}

- (void)performSyncActions {
    [self.syncItems enumerateKeysAndObjectsUsingBlock:^(id key, PPMSyncItem *obj, BOOL *stop) {
        [obj doSync];
    }];
}

@end
