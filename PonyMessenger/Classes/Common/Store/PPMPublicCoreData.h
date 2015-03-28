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

/**
 *  每个应用只拥有一个PublicCoreData实例
 */
@interface PPMPublicCoreData : NSObject

+ (PPMPublicCoreData *)sharedCoreData;

- (void)fetchAccountItemsWithCompletionBlock:(PPMPublicCoreDataAccountItemsFetchingCompletionBlock)completionBlock;

- (PPMManagedAccountItem *)newAccountItem;

- (void)save;

@end
