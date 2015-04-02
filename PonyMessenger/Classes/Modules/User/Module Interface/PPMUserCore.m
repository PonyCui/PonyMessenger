//
//  PPMUserCore.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMUserCore.h"

@implementation PPMUserCore

- (instancetype)init
{
    self = [super init];
    if (self) {
        _userManager = [[PPMUserManager alloc] init];
        _wireframe = [[PPMUserWireframe alloc] init];
    }
    return self;
}

@end
