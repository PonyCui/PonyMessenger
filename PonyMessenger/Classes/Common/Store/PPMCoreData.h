//
//  PPMCoreData.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMManagedUserInformationItem;

typedef void(^PPMCoreDataUserInformationFetchCompletionBlock)(PPMManagedUserInformationItem *item);

@interface PPMCoreData : NSObject

/**
 *  @brief 每个用户都拥有独立的CoreData数据库
 *
 *  @param userID 
 *
 *  @return
 */
- (instancetype)initWithUserID:(NSString *)userID;

- (void)fetchUserInformationWithUserID:(NSString *)userID
                       completionBlock:(PPMCoreDataUserInformationFetchCompletionBlock)completionBlock;

- (PPMManagedUserInformationItem *)newUserInformationItem;

- (void)save;

@end
