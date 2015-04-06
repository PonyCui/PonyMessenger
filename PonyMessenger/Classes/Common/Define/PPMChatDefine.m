//
//  PPMChatDefine.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/3.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatDefine.h"
#import "PPMDefine.h"

@implementation PPMChatDefine

- (NSString *)sessionURLString {
    return [[[PPMDefine sharedDefine] apiAbsolutePath] stringByAppendingString:@"/chat/sessions"];
}

- (NSDictionary *)sessionResponseEagerTypes {
    return @{
             @"data": @"NSArray",
             @"data[]": @"NSDictionary",
             @"session_id": @"NSNumber"
             };
}

- (NSString *)recordURLString {
    return [[[PPMDefine sharedDefine] apiAbsolutePath] stringByAppendingString:@"/chat/records"];
}

- (NSDictionary *)recordResponseEagerTypes {
    return @{
             @"data": @"NSArray",
             @"data[]": @"NSDictionary",
             @"record_id": @"NSNumber",
             @"session_id": @"NSNumber",
             @"from_user_id": @"NSNumber",
             @"record_time": @"NSNumber",
             @"record_type": @"NSNumber",
             @"record_title": @"NSString",
             @"record_params": @"NSString",
             @"record_hash": @"NSString"
             };
}

@end
