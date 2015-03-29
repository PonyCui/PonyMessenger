//
//  PPMPublicCoreData.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-28.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMManagedAccountItem;

typedef void(^PPMPublicCoreDataAccountItemsFetchingCompletionBlock)(NSArray *items);

typedef void(^PPMPublicCoreDataAccountItemFetchingCompletionBlock)(PPMManagedAccountItem *item);

/**
 *  每个应用只拥有一个PublicCoreData实例
 */
@interface PPMPublicCoreData : NSObject

+ (PPMPublicCoreData *)sharedCoreData;

- (void)fetchAccountItemsWithCompletionBlock:(PPMPublicCoreDataAccountItemsFetchingCompletionBlock)completionBlock;

- (void)fetchAccountItemWithUserID:(NSNumber *)userID
                    comletionBlock:(PPMPublicCoreDataAccountItemFetchingCompletionBlock)completionBlock;

- (void)deleteAccountItem:(PPMManagedAccountItem *)item;

- (PPMManagedAccountItem *)newAccountItem;

- (void)save;

@end
