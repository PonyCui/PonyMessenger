//
//  PPMAccountCore.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMAccountCore.h"

@implementation PPMAccountCore

- (instancetype)init
{
    self = [super init];
    if (self) {
        _wireframe = [[PPMAccountWireframe alloc] init];
        _accountManager = [[PPMAccountManager alloc] init];
    }
    return self;
}

@end
