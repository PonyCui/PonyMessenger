//
//  PPMChatSessionItem.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/4.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMManagedChatSessionItem;

typedef NS_ENUM(NSUInteger, PPMChatSessionType) {
    /**
     *  @brief 双人对话
     */
    PPMChatSessionTypePerson = 1,
    /**
     *  @brief 群聊
     */
    PPMChatSessionTypeGroup = 2
};

@interface PPMChatSessionItem : NSObject

@property (nonatomic, strong) NSNumber *sessionID;

@property (nonatomic, strong) NSNumber *sessionType;

@property (nonatomic, copy) NSString *sessionTitle;

@property (nonatomic, copy) NSString *sessionIcon;

@property (nonatomic, strong) NSNumber *sessionLastUpdate;

@property (nonatomic, copy) NSString *sessionLastPost;

@property (nonatomic, copy) NSArray *sessionUserIDS;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithManagedItem:(PPMManagedChatSessionItem *)managedItem;

@end
