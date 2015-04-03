//
//  PPMChatDefine.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/3.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPPMChatRecordDidUpdateNotification @"PPMChatRecordDidUpdateNotification"

@interface PPMChatDefine : NSObject

@property (nonatomic, readonly) NSString *requestRecordsURLString;

@property (nonatomic, readonly) NSDictionary *requestRecordsResponseEagerTypes;

@end
