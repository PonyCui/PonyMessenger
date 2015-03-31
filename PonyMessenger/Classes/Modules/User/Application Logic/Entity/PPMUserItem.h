//
//  PPMUserItem.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMManagedUserInformationItem;

@interface PPMUserItem : NSObject

@property (nonatomic, strong) NSNumber *userID;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *avatarURLString;

- (instancetype)initWithManagedItem:(PPMManagedUserInformationItem *)managedItem;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
