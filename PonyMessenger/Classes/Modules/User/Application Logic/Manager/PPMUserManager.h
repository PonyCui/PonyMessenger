//
//  PPMUserManager.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMUserItem, PPMUserRelationItem;

typedef void(^PPMUserManagerFetchUserInformationCompletionBlock)(PPMUserItem *item);

typedef void(^PPMUserManagerFetchUserInformationsCompletionBlock)(NSArray *items);

typedef void(^PPMUserManagerFetchUserRelationCompletionBlock)(PPMUserRelationItem *item);

typedef void(^PPMUserManagerFetchuserRelationsCompletionBlock)(NSArray *items);

@interface PPMUserManager : NSObject

/**
 *  @brief 获取单个用户信息
 *
 *  @param userID
 *  @param forceUpdate      强制更新数据
 *  @param completionBlock
 */
- (void)fetchUserInformationWithUserID:(NSNumber *)userID
                           forceUpdate:(BOOL)forceUpdate
                       completionBlock:(PPMUserManagerFetchUserInformationCompletionBlock)completionBlock;

/**
 *  @brief 获取多个用户信息
 *
 *  @param userIDArray     
 *  @param forceUpdate     强制更新数据
 *  @param completionBlock
 */
- (void)fetchUserInformationWithUserIDArray:(NSArray *)userIDArray
                                forceUpdate:(BOOL)forceUpdate
                            completionBlock:(PPMUserManagerFetchUserInformationsCompletionBlock)completionBlock;

/**
 *  @brief 获取单个用户关系
 *
 *  @param userID
 *  @param completionBlock
 */
- (void)fetchUserRelationToUserID:(NSNumber *)userID
                  completionBlock:(PPMUserManagerFetchUserRelationCompletionBlock)completionBlock;

/**
 *  @brief 获取所有用户关系
 *
 *  @param completionBlock
 */
- (void)fetchUserRelationsWithCompletionBlock:(PPMUserManagerFetchuserRelationsCompletionBlock)completionBlock;

/**
 *  @brief 更新所有用户关系
 */
- (void)updateRelations;

@end
