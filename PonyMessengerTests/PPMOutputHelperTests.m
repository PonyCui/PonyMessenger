//
//  PPMOutputHelperTests.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-29.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PPMOutputHelper.h"

@interface PPMOutputHelperTests : XCTestCase

@end

@implementation PPMOutputHelperTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testOutputHelper {
    NSDictionary *responseObject = @{
                                     @"error_code": @0,
                                     @"error_description": @"",
                                     @"data" :@{
                                             @"session_access" : @1,
                                             @"session_token" : @"123456",
                                             @"user_id" : @"10",
                                             @"beArray": @{},
                                             @"beDictionary": @[],
                                             @"arrayContainsString": @[@1, @2, @3],
                                             @"arrayContainsArrayContainsString": @[@[@1]]
                                             }
                                     };
    {
        PPMOutputHelper *output = [[PPMOutputHelper alloc] initWithJSONObject:responseObject eagerTypes:@{}];
        [output requestDataObjectWithCompletionBlock:^(id dataObject) {
            XCTAssertTrue([dataObject isKindOfClass:[NSDictionary class]], @"Pass");
            XCTAssertTrue([dataObject[@"session_access"] isKindOfClass:[NSNumber class]], @"Pass");
            XCTAssertEqualObjects(dataObject[@"session_access"], @1);
            XCTAssertEqualObjects(dataObject[@"session_token"], @"123456");
            XCTAssertEqualObjects(dataObject[@"user_id"], @"10");
        }];
    }
    {
        PPMOutputHelper *output = [[PPMOutputHelper alloc]
                                   initWithJSONObject:responseObject
                                           eagerTypes:@{
                                                        @"session_access": @"NSString",
                                                        @"session_token": @"NSString",
                                                        @"user_id": @"NSNumber",
                                                        @"beArray": @"NSArray",
                                                        @"beDictionary": @"NSDictionary",
                                                        @"arrayContainsString[]": @"NSString",
                                                        @"arrayContainsArrayContainsString[][]": @"NSString"
                                                        }];
        [output requestDataObjectWithCompletionBlock:^(id dataObject) {
            XCTAssertTrue([dataObject isKindOfClass:[NSDictionary class]], @"Pass");
            XCTAssertTrue([dataObject[@"session_access"] isKindOfClass:[NSString class]], @"Pass");
            XCTAssertEqualObjects(dataObject[@"session_access"], @"1");
            XCTAssertEqualObjects(dataObject[@"session_token"], @"123456");
            XCTAssertEqualObjects(dataObject[@"user_id"], @10);
            XCTAssertTrue([dataObject[@"beArray"] isKindOfClass:[NSArray class]], @"Pass");
            XCTAssertTrue([dataObject[@"beDictionary"] isKindOfClass:[NSDictionary class]], @"Pass");
            XCTAssertTrue([[dataObject[@"arrayContainsString"] firstObject] isKindOfClass:[NSString class]], @"Pass");
            XCTAssertEqualObjects([dataObject[@"arrayContainsString"] firstObject], @"1");
            XCTAssertTrue([[[dataObject[@"arrayContainsArrayContainsString"] firstObject] firstObject] isKindOfClass:[NSString class]], @"Pass");
            XCTAssertEqualObjects([[dataObject[@"arrayContainsArrayContainsString"] firstObject] firstObject], @"1");
        }];
    }
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
}

@end
