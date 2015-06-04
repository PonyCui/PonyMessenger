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

/**
 *  @param sessions NSArray -> PPMChatSessionItem
 */
typedef void(^PPMChatDataManagerFindSessionsCompletionBlock)(NSArray *sessions);

typedef void(^PPMChatDataManagerPostRecordCompletionBlock)();

typedef void(^PPMChatDataManagerPostRecordFailureBlock)(NSError *error);

/**
 *  @param items NSArray -> PPMChatRecordItem
 */
typedef void(^PPMChatDataManagerFindRecordsCompletionBlock)(NSArray *items);

@interface PPMChatDataManager : NSObject

- (void)findSessionWithUserItem:(PPMUserItem *)userItem completionBlock:(PPMChatDataManagerFindSessionCompletionBlock)completionBlock;

- (void)findSessionWithSessionID:(NSNumber *)sessionID completionBlock:(PPMChatDataManagerFindSessionCompletionBlock)completionBlock;

- (void)updateSessions;

- (void)updateSessionWithETag;

- (void)findRecentSessionsWithCompletionBlock:(PPMChatDataManagerFindSessionsCompletionBlock)completionBlock;

- (void)postWithRecordItem:(PPMChatRecordItem *)recordItem
           completionBlock:(PPMChatDataManagerPostRecordCompletionBlock)completionBlock
              failureBlock:(PPMChatDataManagerPostRecordFailureBlock)failureBlock;

- (void)updateRecords;

- (void)findRecentRecordsWithSessionItem:(PPMChatSessionItem *)sessionItem
                         completionBlock:(PPMChatDataManagerFindRecordsCompletionBlock)completionBlock;

@end
