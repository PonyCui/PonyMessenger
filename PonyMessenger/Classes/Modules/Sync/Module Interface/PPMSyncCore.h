//
//  PPMSyncCore.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPMSyncManager.h"
#import "PPMSyncSocketServiceManager.h"

@interface PPMSyncCore : NSObject

@property (nonatomic, readonly) PPMSyncManager *syncManager;

@property (nonatomic, readonly) PPMSyncSocketServiceManager *socketServiceManager;

@end
