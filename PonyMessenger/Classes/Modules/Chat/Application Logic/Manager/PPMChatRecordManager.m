//
//  PPMChatRecordManager.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/3.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatRecordManager.h"
#import "PPMApplication.h"
#import "PPMPrivateCoreData.h"
#import "PPMValueFormatter.h"
#import "PPMOutputHelper.h"
#import "PPMChatRecordItem.h"
#import "PPMManagedChatRecordItem.h"
#import <AFNetworking/AFNetworking.h>

@implementation PPMChatRecordManager

- (void)updateRecords {
    [UserStore fetchChatLastRecordIDWithCompletionBlock:^(NSNumber *recordID) {
        NSString *URLString = [PPMDefine sharedDefine].chat.requestRecordsURLString;
        [[AFHTTPRequestOperationManager manager]
         GET:URLString
         parameters:@{@"id": TOString(recordID)}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             PPMOutputHelper *opHelper = [[PPMOutputHelper alloc]
                                          initWithJSONObject:responseObject
                                          eagerTypes:[PPMDefine sharedDefine].chat.requestRecordsResponseEagerTypes];
             if (opHelper.error == nil) {
                 [opHelper requestDataObjectWithCompletionBlock:^(NSArray *dataObject) {
                     if ([dataObject count] > 0) {
                         [self deleteStoreItemsGreaterThenRecordID:recordID];
                         [dataObject enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                             PPMChatRecordItem *recordItem = [[PPMChatRecordItem alloc] initWithDictionary:obj];
                             [self updateStoreWithRecordItem:recordItem];
                         }];
                     }
                 }];
             }
        }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", error);
        }];
    }];
}

- (void)deleteStoreItemsGreaterThenRecordID:(NSNumber *)recordID {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"record_id > %@", recordID];
    [UserStore fetchChatRecordWithPredicate:predicate completionBlock:^(NSArray *results) {
        [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [UserStore deleteManagedItem:obj];
        }];
    }];
}

- (void)updateStoreWithRecordItem:(PPMChatRecordItem *)recordItem {
    PPMManagedChatRecordItem *managedItem = [UserStore newChatRecordItem];
    [managedItem setItem:recordItem];
    [UserStore save];
}

@end
