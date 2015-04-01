//
//  PPMSyncCore.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMSyncCore.h"

@interface PPMSyncCore ()

@end

@implementation PPMSyncCore

- (instancetype)init
{
    self = [super init];
    if (self) {
        _syncManager = [[PPMSyncManager alloc] init];
        _socketServiceManager = [[PPMSyncSocketServiceManager alloc] init];
    }
    return self;
}

@end
