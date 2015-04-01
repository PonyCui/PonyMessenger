//
//  PPMSyncCore.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMSyncCore.h"

@interface PPMSyncCore ()

@property (nonatomic, readwrite) PPMSyncManager *syncManager;

@property (nonatomic, readwrite) PPMSyncSocketServiceManager *socketServiceManager;

@end

@implementation PPMSyncCore

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (PPMSyncManager *)syncManager {
    if (_syncManager == nil) {
        _syncManager = [[PPMSyncManager alloc] init];
    }
    return _syncManager;
}

- (PPMSyncSocketServiceManager *)socketServiceManager {
    if (_socketServiceManager == nil) {
        _socketServiceManager = [[PPMSyncSocketServiceManager alloc] init];
    }
    return _socketServiceManager;
}

@end
