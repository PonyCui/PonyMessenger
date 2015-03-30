//
//  PPMAccountSigninInteractor.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMAccountSigninInteractor.h"
#import "PPMApplication.h"
#import "PPMAccountItem.h"

@implementation PPMAccountSigninInteractor

- (void)signinWithEmail:(NSString *)email password:(NSString *)password {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.error = [NSError errorWithDomain:@"A" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"Hello"}];
    });
    return;
    PPMAccountItem *accountItem = [[PPMAccountItem alloc] init];
    accountItem.email = email;
    [[AccountCore accountManager]
     signinWithAccountItem:accountItem
     accountPassword:password
     completionBlock:^{
         self.isSignin = YES;
    }
     failureBlock:^(NSError *error) {
         self.isSignin = NO;
         self.error = error;
    }];
}

@end
