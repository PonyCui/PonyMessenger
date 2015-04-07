//
//  PPMChatRecordManager.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/3.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMUserItem, PPMChatSessionItem, PPMChatRecordItem;

typedef void(^PPMChatDataManagerFindSessionCompletionBlock)(PPMChatSessionItem *sessionItem);

typedef void(^PPMChatDataManagerPostRecordCompletionBlock)();

typedef void(^PPMChatDataManagerPostRecordFailureBlock)(NSError *error);

@interface PPMChatDataManager : NSObject

- (void)findSessionWithUserItem:(PPMUserItem *)userItem completionBlock:(PPMChatDataManagerFindSessionCompletionBlock)completionBlock;

- (void)updateSessions;

- (void)postWithRecordItem:(PPMChatRecordItem *)recordItem
           completionBlock:(PPMChatDataManagerPostRecordCompletionBlock)completionBlock
              failureBlock:(PPMChatDataManagerPostRecordFailureBlock)failureBlock;

- (void)updateRecords;

@end
