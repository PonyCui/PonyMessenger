//
//  User_information.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMManagedUserInformationItem.h"
#import "PPMUserItem.h"


@implementation PPMManagedUserInformationItem

@dynamic user_id;
@dynamic nickname;
@dynamic avatar;

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[PPMUserItem class]]) {
        if ([self.user_id isEqualToNumber:[(PPMUserItem *)object userID]] &&
            [self.nickname isEqualToString:[(PPMUserItem *)object nickname]] &&
            [self.avatar isEqualToString:[(PPMUserItem *)object avatarURLString]]) {
            return YES;
        }
    }
    return NO;
}

@end
