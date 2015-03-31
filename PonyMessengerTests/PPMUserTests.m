//
//  PPMUserTests.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/31.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PPMApplication.h"
#import "PPMUserItem.h"

@interface PPMUserTests : XCTestCase

@end

@implementation PPMUserTests

- (void)setUp {
    [super setUp];
    NSString *setupURLString = [[[PPMDefine sharedDefine] apiAbsolutePath]
                                stringByAppendingString:@"/unittest/setup"];
    [NSData dataWithContentsOfURL:[NSURL URLWithString:setupURLString]];
}

- (void)tearDown {
    [super tearDown];
    NSString *setupURLString = [[[PPMDefine sharedDefine] apiAbsolutePath]
                                stringByAppendingString:@"/unittest/teardown"];
    [NSData dataWithContentsOfURL:[NSURL URLWithString:setupURLString]];
}

- (void)testUserInfo {
    [[UserCore userManager]
     fetchUserInformationWithUserID:@100
     forceUpdate:YES
     completionBlock:^(PPMUserItem *item) {
         XCTAssertTrue([item isKindOfClass:[PPMUserItem class]]);
         XCTAssertEqualObjects(item.userID, @100);
         XCTAssertEqualObjects(item.nickname, @"UnitTester");
         XCTAssertEqualObjects(item.avatarURLString, @"http://tp4.sinaimg.cn/1961248227/180/5706181721/0");
    }];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
}

@end
