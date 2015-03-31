//
//  PPMDefine.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-28.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMDefine.h"
#import <UIKit/UIKit.h>
#import "PPMValueFormatter.h"

@implementation PPMDefine

+ (PPMDefine *)sharedDefine {
    static PPMDefine *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PPMDefine alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _account = [[PPMAccountDefine alloc] init];
        _user = [[PPMUserDefine alloc] init];
    }
    return self;
}

- (NSString *)apiAbsolutePath {
    return @"http://localhost/PonyMessengerServer/index.php";
}

- (NSDictionary *)appParams {
    NSString *deviceToken = TOString([[[UIDevice currentDevice] identifierForVendor] UUIDString]);
    NSString *version = TOString([[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleInfoDictionaryVersionKey]);
    return @{
             @"push_token": @"-",
             @"uuid": deviceToken,
             @"version": version
             };
}

@end
