//
//  PPMCore.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMCore.h"

@implementation PPMCore

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wireframe = [[PPMWireframe alloc] init];
        _chatCore = [[PPMChatCore alloc] init];
        _accountCore = [[PPMAccountCore alloc] init];
    }
    return self;
}

@end
