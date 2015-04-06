//
//  PPMChatRecordManager.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/3.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatDataManager.h"
#import "PPMApplication.h"
#import "PPMPrivateCoreData.h"
#import "PPMValueFormatter.h"
#import "PPMOutputHelper.h"
#import "PPMChatRecordItem.h"
#import "PPMManagedChatRecordItem.h"
#import "PPMChatSessionItem.h"
#import "PPMManagedChatSessionItem.h"
#import "PPMUserItem.h"
#import "PPMChatSessionItem.h"
#import <AFNetworking/AFNetworking.h>

@implementation PPMChatDataManager

#pragma mark - ChatSession

- (void)findSessionWithUserItem:(PPMUserItem *)userItem completionBlock:(PPMChatDataManagerFindSessionCompletionBlock)completionBlock {
    NSString *cacheKey = [NSString stringWithFormat:@"PPM.Chat.Session.User.%@", userItem.userID];
    if ([[UserStore cacheStore] valueForKey:cacheKey] != nil) {
        NSNumber *sessionID = [[UserStore cacheStore] valueForKey:cacheKey];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"session_id = %@", sessionID];
        [UserStore fetchChatSessionWithPredicate:predicate completionBlock:^(NSArray *results) {
            if ([results count] > 0) {
                PPMChatSessionItem *sessionItem = [[PPMChatSessionItem alloc] initWithManagedItem:[results firstObject]];
                completionBlock(sessionItem);
            }
            else {
                completionBlock(nil);
            }
        }];
    }
    else {
        NSString *URLString = [PPMDefine sharedDefine].chat.sessionRaiseURLString;
        [[AFHTTPRequestOperationManager manager]
         POST:URLString
         parameters:@{@"ids": TOString([userItem.userID stringValue])}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             PPMOutputHelper *opHelper = [[PPMOutputHelper alloc]
                                          initWithJSONObject:responseObject
                                          eagerTypes:[PPMDefine sharedDefine].chat.sessionRaiseResponseEagerTypes];
             if (opHelper.error == nil) {
                 [opHelper requestDataObjectWithCompletionBlock:^(NSDictionary *dataObject) {
                     [[UserStore cacheStore] setObject:dataObject[@"session_id"] forKey:cacheKey];
                 }];
             }
        }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
         }];
    }
}

- (void)updateSessions {
    [UserStore fetchChatSessionWithPredicate:nil completionBlock:^(NSArray *results) {
        NSMutableSet *storeItems = [NSMutableSet set];
        [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            PPMChatSessionItem *item = [[PPMChatSessionItem alloc] initWithManagedItem:obj];
            [storeItems addObject:item];
        }];
        NSString *URLString = [PPMDefine sharedDefine].chat.sessionURLString;
        [[AFHTTPRequestOperationManager manager]
         GET:URLString
         parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             PPMOutputHelper *opHelper = [[PPMOutputHelper alloc]
                                          initWithJSONObject:responseObject
                                          eagerTypes:[PPMDefine sharedDefine].chat.sessionResponseEagerTypes];
             if (opHelper.error == nil) {
                 [opHelper requestDataObjectWithCompletionBlock:^(NSArray *dataObject) {
                     NSMutableSet *responseItems = [NSMutableSet set];
                     [dataObject enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                         PPMChatSessionItem *item = [[PPMChatSessionItem alloc] initWithDictionary:obj];
                         [responseItems addObject:item];
                     }];
                     {
                         NSMutableSet *deleteItems = [storeItems mutableCopy];
                         [deleteItems minusSet:responseItems];
                         [[deleteItems copy] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                             [self deleteChatSessionWithSessionItem:obj];
                         }];
                     }
                     {
                         [[responseItems copy] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                             [self updateChatSessionWithSessionItem:obj];
                         }];
                     }
                 }];
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if ([error.localizedDescription isEqualToString:@"The request timed out."]) {
                 [self performSelector:@selector(updateSessions) withObject:nil afterDelay:15.0];
             }
         }];
    }];
}

- (void)deleteChatSessionWithSessionItem:(PPMChatSessionItem *)sessionItem {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"session_id = %@", sessionItem.sessionID];
    [UserStore fetchChatSessionWithPredicate:predicate completionBlock:^(NSArray *results) {
        if ([results count] > 0) {
            [UserStore deleteManagedItem:[results firstObject]];
            [[NSNotificationCenter defaultCenter] postNotificationName:kPPMChatSessionDidUpdateNotification object:nil];
        }
    }];
}

- (void)updateChatSessionWithSessionItem:(PPMChatSessionItem *)sessionItem {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"session_id = %@", sessionItem.sessionID];
    [UserStore fetchChatSessionWithPredicate:predicate completionBlock:^(NSArray *results) {
        PPMManagedChatSessionItem *managedItem;
        if ([results count] > 0) {
            managedItem = [results firstObject];
        }
        else {
            managedItem = [UserStore newChatSessionItem];
        }
        managedItem.session_id = sessionItem.sessionID;
        [UserStore save];
        [[NSNotificationCenter defaultCenter] postNotificationName:kPPMChatSessionDidUpdateNotification object:nil];
    }];
}

#pragma mark - ChatRecord

- (void)updateRecords {
    [UserStore fetchChatLastRecordIDWithCompletionBlock:^(NSNumber *recordID) {
        NSString *URLString = [PPMDefine sharedDefine].chat.recordURLString;
        [[AFHTTPRequestOperationManager manager]
         GET:URLString
         parameters:@{@"id": TOString(recordID)}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             PPMOutputHelper *opHelper = [[PPMOutputHelper alloc]
                                          initWithJSONObject:responseObject
                                          eagerTypes:[PPMDefine sharedDefine].chat.recordResponseEagerTypes];
             if (opHelper.error == nil) {
                 [opHelper requestDataObjectWithCompletionBlock:^(NSArray *dataObject) {
                     if ([dataObject count] > 0) {
                         [dataObject enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                             PPMChatRecordItem *recordItem = [[PPMChatRecordItem alloc] initWithDictionary:obj];
                             [self updateStoreWithRecordItem:recordItem];
                         }];
                     }
                 }];
             }
        }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if ([error.localizedDescription isEqualToString:@"The request timed out."]) {
                 [self performSelector:@selector(updateRecords) withObject:nil afterDelay:15.0];
             }
        }];
    }];
}

- (void)updateStoreWithRecordItem:(PPMChatRecordItem *)recordItem {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"record_id = %@", recordItem.recordID];
    [UserStore fetchChatRecordWithPredicate:predicate completionBlock:^(NSArray *results) {
        if ([results count] == 0) {
            PPMManagedChatRecordItem *managedItem = [UserStore newChatRecordItem];
            [managedItem setItem:recordItem];
            [UserStore save];
            [[NSNotificationCenter defaultCenter] postNotificationName:kPPMChatRecordDidUpdateNotification
                                                                object:recordItem];
        }
    }];
}

@end
