//
//  PPMAccountManager.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-28.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PPMAccountManagerFindAccountItemsCompletionBlock)(NSArray *items);

@interface PPMAccountManager : NSObject

+ (PPMAccountManager *)sharedManager;

- (void)findAccountItemsWithCompletionBlock:(PPMAccountManagerFindAccountItemsCompletionBlock)completionBlock;

@end
