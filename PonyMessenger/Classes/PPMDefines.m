//
//  PPMDefines.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMDefines.h"

@implementation PPMDefines

+ (PPMDefines *)sharedDefines {
    static PPMDefines *define;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        define = [[PPMDefines alloc] init];
    });
    return define;
}

@end
