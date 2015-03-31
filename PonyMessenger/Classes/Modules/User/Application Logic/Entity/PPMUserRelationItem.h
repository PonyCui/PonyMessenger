//
//  PPMUserRelationItem.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/31.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMManagedUserRelationItem;

@interface PPMUserRelationItem : NSObject

/**
 *  @brief 关系用户ID
 */
@property (nonatomic, strong) NSNumber *toUserID;

- (instancetype)initWithManagedItem:(PPMManagedUserRelationItem *)managedItem;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
