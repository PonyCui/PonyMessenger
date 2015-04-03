//
//  PPMChatCore.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatCore.h"
#import "PPMChatRecordManager.h"

@interface PPMChatCore ()

@end

@implementation PPMChatCore

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wireframe = [[PPMChatWireframe alloc] init];
        _recordManager = [[PPMChatRecordManager alloc] init];
    }
    return self;
}

@end
