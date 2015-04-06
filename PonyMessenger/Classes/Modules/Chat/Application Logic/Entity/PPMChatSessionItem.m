//
//  PPMChatSessionItem.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/4.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatSessionItem.h"
#import "PPMManagedChatSessionItem.h"

@implementation PPMChatSessionItem

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        self.sessionID = dictionary[@"session_id"];
    }
    return self;
}

- (instancetype)initWithManagedItem:(PPMManagedChatSessionItem *)managedItem {
    self = [super init];
    if (self && [managedItem isKindOfClass:[PPMManagedChatSessionItem class]]) {
        self.sessionID = managedItem.session_id;
    }
    return self;
}

- (NSUInteger)hash {
    return [self.sessionID unsignedIntegerValue];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[PPMChatSessionItem class]]) {
        return [self.sessionID isEqualToNumber:[(PPMChatSessionItem *)object sessionID]];
    }
    return NO;
}

@end
