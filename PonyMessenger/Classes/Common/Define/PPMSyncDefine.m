//
//  PPMSyncDefine.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMSyncDefine.h"
#import "PPMApplication.h"

@implementation PPMSyncDefine

- (NSString *)requestSocketAddressURLString {
    return [[[PPMDefine sharedDefine] apiAbsolutePath] stringByAppendingString:@"/pubsub"];
}

@end
