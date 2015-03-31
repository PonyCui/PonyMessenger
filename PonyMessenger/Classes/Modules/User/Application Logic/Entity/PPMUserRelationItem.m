//
//  PPMUserRelationItem.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/31.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMUserRelationItem.h"
#import "PPMManagedUserRelationItem.h"

@implementation PPMUserRelationItem

- (instancetype)initWithManagedItem:(PPMManagedUserRelationItem *)managedItem {
    self = [super init];
    if (self && [managedItem isKindOfClass:[PPMManagedUserRelationItem class]]) {
        self.toUserID = managedItem.to_user_id;
    }
    return self;
}

@end
