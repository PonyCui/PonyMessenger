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
