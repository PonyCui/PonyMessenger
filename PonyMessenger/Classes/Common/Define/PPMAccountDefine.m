//
//  PPMAccountDefine.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-28.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMAccountDefine.h"
#import "PPMDefine.h"

@implementation PPMAccountDefine

- (NSString *)signupURLString {
    return [[PPMDefine sharedDefine].apiAbsolutePath stringByAppendingString:@"/user/signup"];
}

- (NSString *)signinURLString {
    return [[PPMDefine sharedDefine].apiAbsolutePath stringByAppendingString:@"/user/signin"];
}

@end
