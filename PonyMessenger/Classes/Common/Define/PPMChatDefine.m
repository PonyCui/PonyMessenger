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

- (NSString *)requestRecordsURLString {
    return [[[PPMDefine sharedDefine] apiAbsolutePath] stringByAppendingString:@"/chat/records"];
}

- (NSDictionary *)requestRecordsResponseEagerTypes {
    return @{
             @"data": @"NSArray",
             @"data[]": @"NSDictionary",
             @"record_id": @"NSNumber",
             @"from_user_id": @"NSNumber",
             @"to_user_id": @"NSNumber",
             @"record_time": @"NSNumber",
             @"record_type": @"NSNumber",
             @"record_title": @"NSString",
             @"record_params": @"NSString",
             @"record_hash": @"NSString"
             };
}

@end
