//
//  PPMAccountManager.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-28.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMAccountManager.h"
#import "PPMPublicCoreData.h"
#import "PPMPrivateCoreData.h"
#import "PPMAccountItem.h"

@interface PPMAccountManager ()

@property (nonatomic, strong) PPMPublicCoreData *applicationStore;

@property (nonatomic, strong) PPMPrivateCoreData *userStore;

@end

@implementation PPMAccountManager

+ (PPMAccountManager *)sharedManager {
    static PPMAccountManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PPMAccountManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.applicationStore = [PPMPublicCoreData sharedCoreData];
        self.userStore = nil;
    }
    return self;
}

- (void)findAccountItemsWithCompletionBlock:(PPMAccountManagerFindAccountItemsCompletionBlock)completionBlock {
    [[PPMPublicCoreData sharedCoreData] fetchAccountItemsWithCompletionBlock:^(NSArray *items) {
        NSMutableArray *accountItems = [NSMutableArray array];
        [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            PPMAccountItem *item = [[PPMAccountItem alloc] initWithManagedAccountItem:obj];
            if (item != nil) {
                [accountItems addObject:item];
            }
        }];
        completionBlock([accountItems copy]);
    }];
}

- (void)signupWithAccountItem:(PPMAccountItem *)accountItem
              accountPassword:(NSString *)accountPassword
              completionBlock:(PPMAccountManagerSignupCompletionBlock)completionBlock
                 failureBlock:(PPMAccountManagerSignupFailureBlock)failureBlock {
    
}

- (void)signinWithAccountItem:(PPMAccountItem *)accountItem
              accountPassword:(NSString *)accountPassword
              completionBlock:(PPMAccountManagerSigninCompletionBlock)completionBlock
                 failureBlock:(PPMAccountManagerSigninFailureBlock)failureBlock {
    
}

- (void)signout {
    
}

@end
