//
//  PPMUserDefine.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/31.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMUserDefine.h"
#import "PPMDefine.h"

@implementation PPMUserDefine

- (NSString *)infoURLString {
    return [[PPMDefine sharedDefine].apiAbsolutePath stringByAppendingString:@"/user/info"];
}

- (NSDictionary *)infoResponseEagerTypes {
    return @{
             @"data": @"NSDictionary",
             @"user_id": @"NSNumber",
             @"nickname": @"NSString",
             @"avatar": @"NSString"
             };
}

- (NSString *)infosURLString {
    return [[PPMDefine sharedDefine].apiAbsolutePath stringByAppendingString:@"/user/infos"];
}

- (NSDictionary *)infosResponseEagerTypes {
    return @{
             @"data": @"NSArray",
             @"data[]": @"NSDictionary",
             @"user_id": @"NSNumber",
             @"nickname": @"NSString",
             @"avatar": @"NSString"
             };
}

@end
