//
//  PPMAccountManager.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-28.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMAccountManager.h"
#import "PPMPublicCoreData.h"
#import "PPMManagedAccountItem.h"
#import "PPMPrivateCoreData.h"
#import "PPMAccountItem.h"
#import "PPMDefine.h"
#import "PPMOutputHelper.h"
#import <AFNetworking/AFNetworking.h>
#import <SSKeychain/SSKeychain.h>

@interface PPMAccountManager ()

@property (nonatomic, strong) PPMPublicCoreData *applicationStore;

@property (nonatomic, strong) PPMPrivateCoreData *userStore;

@end

@implementation PPMAccountManager

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

- (void)findActiveAccountItemWithCompletionBlock:(PPMAccountManagerFindActiveAccountItemCompletionBlock)completionBlock {
    [self findAccountItemsWithCompletionBlock:^(NSArray *items) {
        __block PPMAccountItem *item;
        [items enumerateObjectsUsingBlock:^(PPMAccountItem *obj, NSUInteger idx, BOOL *stop) {
            NSString *password = [SSKeychain passwordForService:@"PPM.Account" account:[obj.userID stringValue]];
            if (password != nil) {
                item = obj;
                item.sessionToken = password;
                *stop = YES;
            }
        }];
        [self setActiveAccount:item];
        completionBlock(item);
    }];
}

- (void)findLastActiveAccountItemWithCompletionBlock:(PPMAccountManagerFindActiveAccountItemCompletionBlock)completionBlock {
    
}

- (void)signupWithAccountItem:(PPMAccountItem *)accountItem
              accountPassword:(NSString *)accountPassword
              completionBlock:(PPMAccountManagerSignupCompletionBlock)completionBlock
                 failureBlock:(PPMAccountManagerSignupFailureBlock)failureBlock {
    if (accountItem.email == nil || accountPassword == nil || !accountPassword.length) {
        NSError *error = [NSError errorWithDomain:@"PPM.Account" code:NSIntegerMin userInfo:nil];
        if (failureBlock) {
            failureBlock(error);
        }
        return ;
    }
    NSString *URLString = [[[PPMDefine sharedDefine] account] signupURLString];
    NSDictionary *params = @{
                             @"email": accountItem.email,
                             @"password": accountPassword
                             };
    [[AFHTTPRequestOperationManager manager]
     POST:URLString
     parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         PPMOutputHelper *output = [[PPMOutputHelper alloc]
                                    initWithJSONObject:responseObject
                                    eagerTypes:[PPMDefine sharedDefine].account.signupResponseEagerTypes];
         if (output.error == nil) {
             [output requestDataObjectWithCompletionBlock:^(id dataObject) {
                 accountItem.userID = dataObject[@"user_id"];
                 accountItem.sessionToken = dataObject[@"session_token"];
                 [self setActiveAccount:accountItem];
                 if (completionBlock) {
                     completionBlock(accountItem);
                 }
             }];
         }
         else {
             if (failureBlock) {
                 failureBlock(output.error);
             }
         }
    }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failureBlock) {
             failureBlock(error);
         }
    }];
}

- (void)signinWithAccountItem:(PPMAccountItem *)accountItem
              accountPassword:(NSString *)accountPassword
              completionBlock:(PPMAccountManagerSigninCompletionBlock)completionBlock
                 failureBlock:(PPMAccountManagerSigninFailureBlock)failureBlock {
    if (accountItem.email == nil || accountPassword == nil || !accountPassword.length) {
        NSError *error = [NSError errorWithDomain:@"PPM.Account" code:NSIntegerMin userInfo:@{NSLocalizedDescriptionKey: @"Need email and password."}];
        if (failureBlock) {
            failureBlock(error);
        }
        return ;
    }
    NSString *URLString = [[[PPMDefine sharedDefine] account] signinURLString];
    NSDictionary *params = @{
                             @"email": accountItem.email,
                             @"password": accountPassword
                             };
    [[AFHTTPRequestOperationManager manager]
     POST:URLString
     parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         PPMOutputHelper *output = [[PPMOutputHelper alloc]
                                    initWithJSONObject:responseObject
                                    eagerTypes:[PPMDefine sharedDefine].account.signinResponseEagerTypes];
         if (output.error == nil) {
             [output requestDataObjectWithCompletionBlock:^(id dataObject) {
                 accountItem.userID = dataObject[@"user_id"];
                 accountItem.sessionToken = dataObject[@"session_token"];
                 [self setActiveAccount:accountItem];
                 if (completionBlock) {
                     completionBlock(accountItem);
                 }
             }];
         }
         else {
             if (failureBlock) {
                 failureBlock(output.error);
             }
         }
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failureBlock) {
             failureBlock(error);
         }
     }];
}

- (void)setActiveAccount:(PPMAccountItem *)activeAccount {
    _activeAccount = activeAccount;
    [self addAccountToApplicationStore:activeAccount];
    [self configureKeychainWithAccountItem:activeAccount];
    [self configureUserStoreWithAccountItem:activeAccount];
}

- (void)addAccountToApplicationStore:(PPMAccountItem *)accountItem {
    [self.applicationStore fetchAccountItemWithUserID:accountItem.userID comletionBlock:^(PPMManagedAccountItem *item) {
        if (item != nil) {
            item.email = accountItem.email;
        }
        else {
            PPMManagedAccountItem *managedAccountItem = [self.applicationStore newAccountItem];
            managedAccountItem.user_id = accountItem.userID;
            managedAccountItem.email = accountItem.email;
        }
        [self.applicationStore save];
    }];
}

- (void)deleteAccountFromApplicationStore:(PPMAccountItem *)accountItem {
    [self.applicationStore fetchAccountItemWithUserID:accountItem.userID comletionBlock:^(PPMManagedAccountItem *item) {
        if (item != nil) {
            [self.applicationStore deleteAccountItem:item];
        }
    }];
    NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [applicationDocumentsDirectory
                       URLByAppendingPathComponent:[NSString stringWithFormat:@"PPM.%@.sqlite", accountItem.userID]];
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:NULL];
}

- (void)configureKeychainWithAccountItem:(PPMAccountItem *)accountItem {
    [SSKeychain setPassword:accountItem.sessionToken
                 forService:@"PPM.Account"
                    account:[accountItem.userID stringValue]];
}

- (void)configureUserStoreWithAccountItem:(PPMAccountItem *)accountItem {
    self.userStore = [[PPMPrivateCoreData alloc] initWithUserID:accountItem.userID];
}

- (void)signout {
    [self configureLastActiveAccountItem:self.activeAccount];
    [SSKeychain deletePasswordForService:@"PPM.Account" account:[self.activeAccount.userID stringValue]];
    self.userStore = nil;
}

- (PPMAccountItem *)lastActiveAccount {
    NSData *lastActiveAccountData = [[NSUserDefaults standardUserDefaults] valueForKey:@"PPM.Account.LastActive"];
    if (lastActiveAccountData != nil) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:lastActiveAccountData];
    }
    return nil;
}

- (void)configureLastActiveAccountItem:(PPMAccountItem *)accountItem {
    NSData *lastActiveAccountData = [NSKeyedArchiver archivedDataWithRootObject:accountItem];
    if (lastActiveAccountData != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:lastActiveAccountData forKey:@"PPM.Account.LastActive"];
    }
}

@end
