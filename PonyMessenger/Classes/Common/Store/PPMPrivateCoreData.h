//
//  PPMCoreData.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMManagedUserInformationItem, PPMManagedUserRelationItem, NSManagedObject;

/**
 *  @param item NSArray -> PPMManagedUserInformationItem
 */
typedef void(^PPMPrivateCoreDataUserInformationFetchCompletionBlock)(NSArray *results);

/**
 *  @param results NSArray -> PPMManagedUserRelationItem
 */
typedef void(^PPMPrivateCoreDataUserRelationFetchCompletionBlock)(NSArray *results);

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

- (void)save;

- (void)deleteManagedItem:(NSManagedObject *)managedItem;

@end
