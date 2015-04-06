//
//  PPMChatSessionItem.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/4.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMManagedChatSessionItem;

@interface PPMChatSessionItem : NSObject

@property (nonatomic, strong) NSNumber *sessionID;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithManagedItem:(PPMManagedChatSessionItem *)managedItem;

@end
