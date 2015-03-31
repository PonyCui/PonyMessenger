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
#import "PPMUserRelationItem.h"
#import "PPMValueFormatter.h"
#import "PPMManagedUserRelationItem.h"
#import <AFNetworking/AFNetworking.h>

@implementation PPMUserManager

#pragma mark - UserInformation

- (void)fetchUserInformationWithUserID:(NSNumber *)userID
                           forceUpdate:(BOOL)forceUpdate
                       completionBlock:(PPMUserManagerFetchUserInformationCompletionBlock)completionBlock {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user_id = %@", userID];
    [[[AccountCore accountManager] userStore] fetchUserInformationWithPredicate:predicate completionBlock:^(NSArray *results) {
        PPMManagedUserInformationItem *item = [results firstObject];
        if (item != nil) {
            if (completionBlock) {
                PPMUserItem *userItem = [[PPMUserItem alloc] initWithManagedItem:item];
                completionBlock(userItem);
            }
            if (forceUpdate || ![self isUserInformationValidForUserID:userID]) {
                [self updateUserInformationWithUserID:userID];
            }
        }
        else {
            [self updateUserInformationWithUserID:userID];
        }
    }];
}

- (void)fetchUserInformationWithUserIDArray:(NSArray *)userIDArray
                                forceUpdate:(BOOL)forceUpdate
                            completionBlock:(PPMUserManagerFetchUserInformationsCompletionBlock)completionBlock {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user_id IN %@", userIDArray];
    [[[AccountCore accountManager] userStore] fetchUserInformationWithPredicate:predicate completionBlock:^(NSArray *results) {
        NSMutableArray *beUpdateduserIDArray = [NSMutableArray array];
        NSMutableArray *userItems = [NSMutableArray array];
        [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            PPMUserItem *userItem = [[PPMUserItem alloc] initWithManagedItem:obj];
            [userItems addObject:userItem];
            if (forceUpdate || ![self isUserInformationValidForUserID:userItem.userID]) {
                if (userItem.userID != nil) {
                    [beUpdateduserIDArray addObject:userItem.userID];
                }
            }
        }];
        if (completionBlock) {
            completionBlock([userItems copy]);
        }
        if ([beUpdateduserIDArray count] > 0) {
            [self updateUsersInformationWithUserIDArray:[beUpdateduserIDArray copy]];
        }
    }];
}

- (void)updateUserInformationWithUserID:(NSNumber *)userID {
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
             }];
         }
    }
     failure:nil];
}

- (void)updateUsersInformationWithUserIDArray:(NSArray *)userIDArray {
    NSString *URLString = [[[PPMDefine sharedDefine] user] infosURLString];
    NSString *idsString = [userIDArray componentsJoinedByString:@","];
    NSDictionary *params = @{
                             @"ids": TOString(idsString)
                             };
    [[AFHTTPRequestOperationManager manager]
     GET:URLString
     parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         PPMOutputHelper *opHelper = [[PPMOutputHelper alloc]
                                      initWithJSONObject:responseObject
                                      eagerTypes:[[[PPMDefine sharedDefine] user] infosResponseEagerTypes]];
         if (opHelper.error == nil) {
             [opHelper requestDataObjectWithCompletionBlock:^(NSArray *dataObject) {
                 [dataObject enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                     PPMUserItem *userItem = [[PPMUserItem alloc] initWithDictionary:obj];
                     [self updateUserStoreWithUserItem:userItem];
                 }];
             }];
         }
    }
     failure:nil];
}

- (void)updateUserStoreWithUserItem:(PPMUserItem *)userItem {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user_id = %@", userItem.userID];
    [UserStore fetchUserInformationWithPredicate:predicate completionBlock:^(NSArray *results) {
        PPMManagedUserInformationItem *item = [results firstObject];
        if (item == nil) {
            item = [UserStore newUserInformationItem];
        }
        else if ([item isEqual:userItem]) {
            return ;//完全一致，无须入库
        }
        item.user_id = userItem.userID;
        item.nickname = userItem.nickname;
        item.avatar = userItem.avatarURLString;
        [UserStore save];
        [[NSNotificationCenter defaultCenter] postNotificationName:kPPMUserInformationUpdatedNotification
                                                            object:userItem];
    }];
    NSString *cacheKey = [NSString stringWithFormat:@"PPM.UserInformation.ExpiredsTime.%@", userItem.userID];
    NSDate *expiredDate = [NSDate dateWithTimeIntervalSinceNow:[[[PPMDefine sharedDefine] user] infoCacheTimeout]];
    [[UserStore cacheStore] setValue:expiredDate forKey:cacheKey];
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

#pragma mark - UserRelation

- (void)fetchUserRelationToUserID:(NSNumber *)userID
                  completionBlock:(PPMUserManagerFetchUserRelationCompletionBlock)completionBlock {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"to_user_id = %@", userID];
    [UserStore fetchUserRelationWithPredicate:predicate completionBlock:^(NSArray *results) {
        if (completionBlock) {
            if ([results firstObject] != nil) {
                PPMUserRelationItem *relationItem = [[PPMUserRelationItem alloc]
                                                     initWithManagedItem:[results firstObject]];
                completionBlock(relationItem);
            }
            else {
                completionBlock(nil);
            }
        }
    }];
}

- (void)fetchUserRelationsWithCompletionBlock:(PPMUserManagerFetchuserRelationsCompletionBlock)completionBlock {
    [UserStore fetchUserRelationWithPredicate:nil completionBlock:^(NSArray *results) {
        if (completionBlock) {
            NSMutableArray *relationItems = [NSMutableArray array];
            [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                PPMUserRelationItem *relationItem = [[PPMUserRelationItem alloc]
                                                     initWithManagedItem:obj];
                [relationItems addObject:relationItem];
            }];
            completionBlock([relationItems copy]);
        }
    }];
}

- (void)updateUserRelationWithRelationItem:(PPMUserRelationItem *)relationItem {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"to_user_id = %@", relationItem.toUserID];
    [UserStore fetchUserRelationWithPredicate:predicate completionBlock:^(NSArray *results) {
        PPMManagedUserRelationItem *managedItem = [results firstObject];
        if (managedItem == nil) {
            managedItem = [UserStore newUserRelationItem];
        }
        else if ([managedItem isEqual:relationItem]) {
            return ;
        }
        managedItem.to_user_id = relationItem.toUserID;
        [UserStore save];
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPPMUserRelationUpdatedNotification object:nil];
}



@end
