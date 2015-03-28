//
//  PPMAccountItem.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-28.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMManagedAccountItem;

@interface PPMAccountItem : NSObject

@property (nonatomic, strong) NSNumber *userID;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *sessionToken;

- (instancetype)initWithManagedAccountItem:(PPMManagedAccountItem *)managedItem;

@end
