//
//  PPMChatRecordItem.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/3.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMManagedChatRecordItem;

@interface PPMChatRecordItem : NSObject

@property (nonatomic, strong) NSNumber *recordID;

@property (nonatomic, copy) NSString *sessionID;

@property (nonatomic, strong) NSNumber *fromUserID;

@property (nonatomic, strong) NSNumber *toUserID;

@property (nonatomic, strong) NSNumber *recordTime;

@property (nonatomic, strong) NSNumber *recordType;

@property (nonatomic, strong) NSString *recordTitle;

@property (nonatomic, copy) NSString *recordParams;

@property (nonatomic, copy) NSString *recordHash;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithManagedItem:(PPMManagedChatRecordItem *)managedItem;

@end
