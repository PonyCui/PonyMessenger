//
//  PPMAccountManager.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-28.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMPrivateCoreData, PPMAccountItem;

typedef void(^PPMAccountManagerFindAccountItemsCompletionBlock)(NSArray *items);

typedef void(^PPMAccountManagerSignupCompletionBlock)(PPMAccountItem *item);

typedef void(^PPMAccountManagerSignupFailureBlock)(NSError *error);

typedef void(^PPMAccountManagerSigninCompletionBlock)();

typedef void(^PPMAccountManagerSigninFailureBlock)(NSError *error);

@interface PPMAccountManager : NSObject

+ (PPMAccountManager *)sharedManager;

@property (nonatomic, readonly) PPMPrivateCoreData *userStore;

- (void)findAccountItemsWithCompletionBlock:(PPMAccountManagerFindAccountItemsCompletionBlock)completionBlock;

- (void)signupWithAccountItem:(PPMAccountItem *)accountItem
              accountPassword:(NSString *)accountPassword
              completionBlock:(PPMAccountManagerSignupCompletionBlock)completionBlock
                 failureBlock:(PPMAccountManagerSignupFailureBlock)failureBlock;

- (void)signinWithAccountItem:(PPMAccountItem *)accountItem
              accountPassword:(NSString *)accountPassword
              completionBlock:(PPMAccountManagerSigninCompletionBlock)completionBlock
                 failureBlock:(PPMAccountManagerSigninFailureBlock)failureBlock;

- (void)signout;

@end
