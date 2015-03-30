//
//  PPMAccountItem.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-28.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMAccountItem.h"
#import "PPMManagedAccountItem.h"

@implementation PPMAccountItem

- (instancetype)initWithManagedAccountItem:(PPMManagedAccountItem *)managedItem {
    self = [super init];
    if (self && [managedItem isKindOfClass:[PPMManagedAccountItem class]]) {
        self.userID = managedItem.user_id;
        self.email = managedItem.email;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.userID = [coder decodeObjectForKey:@"userID"];
        self.email = [coder decodeObjectForKey:@"email"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.email forKey:@"email"];
}

@end
