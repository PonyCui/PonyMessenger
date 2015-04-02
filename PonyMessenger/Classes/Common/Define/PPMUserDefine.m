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

- (NSTimeInterval)infoCacheTimeout {
    return 3600;
}

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

- (NSString *)relationsURLString {
    return [[PPMDefine sharedDefine].apiAbsolutePath stringByAppendingString:@"/user/relation"];
}

- (NSDictionary *)relationsResponseEagerTypes {
    return @{
             @"data": @"NSArray",
             @"data[]": @"NSDictionary",
             @"to_user_id": @"NSNumber"
             };
}

- (NSString *)searchURLString {
    return [[PPMDefine sharedDefine].apiAbsolutePath stringByAppendingString:@"/user/search"];
}

- (NSDictionary *)searchResponseEagerTypes {
    return @{
             @"data": @"NSArray",
             @"data[]": @"NSNumber"
             };
}

@end
