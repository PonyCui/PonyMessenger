//
//  PPMAccountSignupInteractor.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMAccountSignupInteractor.h"
#import "PPMApplication.h"
#import "PPMAccountItem.h"

@implementation PPMAccountSignupInteractor

- (void)signupWithEmail:(NSString *)email password:(NSString *)password {
    PPMAccountItem *accountItem = [[PPMAccountItem alloc] init];
    accountItem.email = email;
    [[AccountCore accountManager]
     signupWithAccountItem:accountItem
     accountPassword:password
     completionBlock:^(PPMAccountItem *item) {
         self.isSignup = YES;
         self.error = nil;
    }
     failureBlock:^(NSError *error) {
         self.isSignup = NO;
         self.error = error;
    }];
}

@end
