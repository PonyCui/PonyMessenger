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
#import "PPMOutputHelper.h"
#import "PPMManagedUserInformationItem.h"
#import <AFNetworking/AFNetworking.h>

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
    NSString *URLString = [[[PPMDefine sharedDefine] user] infoURLString];
    NSDictionary *params = @{
                             @"user_id": [userID stringValue]
                             };
    [[AFHTTPRequestOperationManager manager]
     GET:URLString
     parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         PPMOutputHelper *opHelper = [[PPMOutputHelper alloc]
                                      initWithJSONObject:responseObject
                                      eagerTypes:[[[PPMDefine sharedDefine] user] infoResponseEagerTypes]];
         if (opHelper.error == nil) {
             [opHelper requestDataObjectWithCompletionBlock:^(id dataObject) {
                 PPMUserItem *userItem = [[PPMUserItem alloc] initWithDictionary:dataObject];
                 [self updateUserStoreWithUserItem:userItem];
                 if (completionBlock) {
                     completionBlock(userItem);
                 }
             }];
         }
    }
     failure:nil];
}

- (void)updateUserStoreWithUserItem:(PPMUserItem *)userItem {
    [UserStore fetchUserInformationWithUserID:userItem.userID completionBlock:^(PPMManagedUserInformationItem *item) {
        if (item == nil) {
            item = [UserStore newUserInformationItem];
        }
        item.user_id = userItem.userID;
        item.nickname = userItem.nickname;
        item.avatar = userItem.avatarURLString;
        [UserStore save];
    }];
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
