//
//  PPMApplication.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMApplication.h"
#import "PPMCore.h"

@interface PPMApplication ()

@end

@implementation PPMApplication

+ (PPMApplication *)sharedApplication {
    static PPMApplication *application;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        application = [[PPMApplication alloc] init];
    });
    return application;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _core = [[PPMCore alloc] init];
    }
    return self;
}

@end
