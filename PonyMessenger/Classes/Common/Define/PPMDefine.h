//
//  PPMDefine.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-28.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPMAccountDefine.h"
#import "PPMUserDefine.h"
#import "PPMSyncDefine.h"
#import "PPMChatDefine.h"

@interface PPMDefine : NSObject

+ (PPMDefine *)sharedDefine;

@property (nonatomic, readonly) PPMAccountDefine *account;

@property (nonatomic, readonly) PPMUserDefine *user;

@property (nonatomic, readonly) PPMSyncDefine *sync;

@property (nonatomic, readonly) PPMChatDefine *chat;

@property (nonatomic, readonly) NSString *apiAbsolutePath;

@property (nonatomic, readonly) NSDictionary *appParams;

@end
