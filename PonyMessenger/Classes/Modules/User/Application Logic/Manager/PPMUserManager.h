//
//  PPMUserManager.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMUserItem;

typedef void(^PPMUserManagerFetchUserInformationCompletionBlock)(PPMUserItem *item);

typedef void(^PPMUserManagerFetchUserInformationsCompletionBlock)(NSArray *items);

@interface PPMUserManager : NSObject

/**
 *  @brief 获取单个用户信息
 *
 *  @param userID
 *  @param forceUpdate 强制从服务器获取数据，并更新缓存，这样只会回调一次
 *  @param completionBlock 若数据需要更新，则会触发两次回调
 */
- (void)fetchUserInformationWithUserID:(NSNumber *)userID
                           forceUpdate:(BOOL)forceUpdate
                       completionBlock:(PPMUserManagerFetchUserInformationCompletionBlock)completionBlock;

/**
 *  @brief 获取多个用户信息
 *
 *  @param userIDArray     
 *  @param forceUpdate     强制从服务器获取数据，并更新缓存，这样只会回调一次
 *  @param completionBlock 若数据需要更新，则会触发两次回调
 */
- (void)fetchUserInformationWithUserIDArray:(NSArray *)userIDArray
                                forceUpdate:(BOOL)forceUpdate
                            completionBlock:(PPMUserManagerFetchUserInformationsCompletionBlock)completionBlock;

@end
