//
//  PPMSyncSocketServiceManager.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMSyncConnService, PPMSyncSubService, PPMSyncTestService;

@interface PPMSyncSocketServiceManager : NSObject

@property (nonatomic, readonly) PPMSyncConnService *conn;

@property (nonatomic, readonly) PPMSyncSubService *sub;

@property (nonatomic, readonly) PPMSyncTestService *test;

@end
