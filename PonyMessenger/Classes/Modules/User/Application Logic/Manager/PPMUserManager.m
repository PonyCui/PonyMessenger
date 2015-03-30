//
//  PPMUserManager.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMUserManager.h"
#import "PPMUserItem.h"
#import "PPMApplication.h"
#import "PPMPrivateCoreData.h"

@implementation PPMUserManager

- (void)fetchUserInformationWithUserID:(NSNumber *)userID
                           forceUpdate:(BOOL)forceUpdate
                       completionBlock:(PPMUserManagerFetchUserInformationCompletionBlock)completionBlock {
    if (forceUpdate) {
        [self updateUserInformationWithUserID:userID completionBlock:^(PPMUserItem *item) {
            if (completionBlock) {
                completionBlock(item);
            }
        }];
    }
    else {
        [[[AccountCore accountManager] userStore] fetchUserInformationWithUserID:userID completionBlock:^(PPMManagedUserInformationItem *item) {
            if (item != nil) {
                if (completionBlock) {
                    PPMUserItem *userItem = [[PPMUserItem alloc] initWithManagedItem:item];
                    completionBlock(userItem);
                }
                if (![self isUserInformationValidForUserID:userID]) {
                    [self updateUserInformationWithUserID:userID completionBlock:^(PPMUserItem *item) {
                        if (completionBlock) {
                            completionBlock(item);
                        }
                    }];
                }
            }
            else {
                [self updateUserInformationWithUserID:userID completionBlock:^(PPMUserItem *item) {
                    if (completionBlock) {
                        completionBlock(item);
                    }
                }];
            }
        }];
    }
}

- (void)fetchUserInformationWithUserIDArray:(NSArray *)userIDArray
                                forceUpdate:(BOOL)forceUpdate
                            completionBlock:(PPMUserManagerFetchUserInformationsCompletionBlock)completionBlock {
    
}

- (void)updateUserInformationWithUserID:(NSNumber *)userID
                        completionBlock:(void (^)(PPMUserItem *item))completionBlock {
    
}

- (BOOL)isUserInformationValidForUserID:(NSNumber *)userID {
    NSString *cacheKey = [NSString stringWithFormat:@"PPM.UserInformation.ExpiredsTime.%@", userID];
    NSDate *cacheValue = [[[[AccountCore accountManager] userStore] cacheStore] valueForKey:cacheKey];
    if (cacheValue == nil) {
        return NO;
    }
    else if ([cacheValue timeIntervalSinceNow] < 0) {
        return NO;
    }
    else {
        return YES;
    }
}

@end
