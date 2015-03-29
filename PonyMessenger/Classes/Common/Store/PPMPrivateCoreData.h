//
//  PPMCoreData.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMManagedUserInformationItem;

typedef void(^PPMPrivateCoreDataUserInformationFetchCompletionBlock)(PPMManagedUserInformationItem *item);

/**
 * @brief  每个用户都拥有独立的PrivateCoreData实例
 */
@interface PPMPrivateCoreData : NSObject

/**
 *  @param userID 
 */
- (instancetype)initWithUserID:(NSNumber *)userID;

- (void)fetchUserInformationWithUserID:(NSNumber *)userID
                       completionBlock:(PPMPrivateCoreDataUserInformationFetchCompletionBlock)completionBlock;

- (PPMManagedUserInformationItem *)newUserInformationItem;

- (void)save;

@end
