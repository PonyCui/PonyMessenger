//
//  PPMAccountTests.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-28.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PPMPublicCoreData.h"
#import "PPMManagedAccountItem.h"

@interface PPMAccountTests : XCTestCase

@end

@implementation PPMAccountTests

- (void)setUp {
    [super setUp];
    NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [applicationDocumentsDirectory
                       URLByAppendingPathComponent:[NSString stringWithFormat:@"PPM.%@.sqlite", @"0"]];
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:NULL];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAccountStore {
    {
        PPMManagedAccountItem *item = [[PPMPublicCoreData sharedCoreData] newAccountItem];
        item.user_id = @1;
        item.email = @"ponycui@me.com";
    }
    {
        PPMManagedAccountItem *item = [[PPMPublicCoreData sharedCoreData] newAccountItem];
        item.user_id = @2;
        item.email = @"apple@me.com";
    }
    [[PPMPublicCoreData sharedCoreData] save];
    
    [[PPMPublicCoreData sharedCoreData] fetchAccountItemsWithCompletionBlock:^(NSArray *items) {
        XCTAssert([[[items firstObject] user_id] isEqualToNumber:@1], @"Pass");
        XCTAssert([[[items lastObject] user_id] isEqualToNumber:@2], @"Pass");
    }];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
}

@end
