//
//  PPMCoreData.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMManagedUserInformationItem, PPMManagedUserRelationItem, PPMManagedChatRecordItem, PPMManagedChatSessionItem, PPMManagedChatSessionUserItem, NSManagedObject;

/**
 *  @param item NSArray -> PPMManagedUserInformationItem
 */
typedef void(^PPMPrivateCoreDataUserInformationFetchCompletionBlock)(NSArray *results);

/**
 *  @param results NSArray -> PPMManagedUserRelationItem
 */
typedef void(^PPMPrivateCoreDataUserRelationFetchCompletionBlock)(NSArray *results);

/**
 *  @param results NSArray -> PPMManagedChatSessionItem
 */
typedef void(^PPMPrivateCoreDataChatSessionFetchCompletionBlock)(NSArray *results);

typedef void(^PPMPrivateCoreDataChatSessionLastUpdateFetchCompletionBlock)(NSNumber *lastUpdate);

/**
 *  @param results NSArray -> PPMManagedChatSessionUserItem
 */
typedef void(^PPMPrivateCoreDataChatSessionUserFetchCompletionBlock)(NSArray *results);

/**
 *  @param results NSArray -> PPMManagedChatRecordItem
 */
typedef void(^PPMPrivateCoreDataChatRecordFetchCompletionBlock)(NSArray *results);

/**
 *  @param recordID
 */
typedef void(^PPMPrivateCoreDataChatLastRecordIDFetchCompletionBlock)(NSNumber *recordID);

/**
 * @brief  每个用户都拥有独立的PrivateCoreData实例
 */
@interface PPMPrivateCoreData : NSObject

@property (nonatomic, readonly) NSUserDefaults *cacheStore;

/**
 *  @param userID 
 */
- (instancetype)initWithUserID:(NSNumber *)userID;

- (void)fetchUserInformationWithPredicate:(NSPredicate *)predicate
                          completionBlock:(PPMPrivateCoreDataUserInformationFetchCompletionBlock)completionBlock;

- (PPMManagedUserInformationItem *)newUserInformationItem;

- (void)fetchUserRelationWithPredicate:(NSPredicate *)predicate
                     completionBlock:(PPMPrivateCoreDataUserRelationFetchCompletionBlock)completionBlock;

- (PPMManagedUserRelationItem *)newUserRelationItem;

- (void)fetchChatSessionWithPredicate:(NSPredicate *)predicate
                      completionBlock:(PPMPrivateCoreDataChatSessionFetchCompletionBlock)completionBlock;

- (void)fetchChatSessionsOrderByDescWithCompltionBlock:(PPMPrivateCoreDataChatSessionFetchCompletionBlock)completionBlock;

- (PPMManagedChatSessionItem *)newChatSessionItem;

- (void)fetchChatSessionUserWithPredicate:(NSPredicate *)predicate
                          completionBlock:(PPMPrivateCoreDataChatSessionUserFetchCompletionBlock)completionBlock;

- (void)fetchChatSessionLastUpdateWithCompletionBlock:(PPMPrivateCoreDataChatSessionLastUpdateFetchCompletionBlock)completionBlock;

- (PPMManagedChatSessionUserItem *)newChatSessionUserItem;

- (void)fetchChatRecordWithPredicate:(NSPredicate *)predicate
                     completionBlock:(PPMPrivateCoreDataChatRecordFetchCompletionBlock)completionBlock;

- (void)fetchChatRecordWithSessionID:(NSNumber *)sessionID
                            lessThen:(NSNumber *)recordID
                     completionBlock:(PPMPrivateCoreDataChatRecordFetchCompletionBlock)completionBlock;

- (void)fetchChatLastRecordIDWithCompletionBlock:(PPMPrivateCoreDataChatLastRecordIDFetchCompletionBlock)completionBlock;

- (PPMManagedChatRecordItem *)newChatRecordItem;

- (void)save;

- (void)deleteManagedItem:(NSManagedObject *)managedItem;

@end
