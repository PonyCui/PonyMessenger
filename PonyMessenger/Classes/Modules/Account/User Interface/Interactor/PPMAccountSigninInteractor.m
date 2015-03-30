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
    PPMAccountItem *accountItem = [[PPMAccountItem alloc] init];
    accountItem.email = email;
    [[AccountCore accountManager]
     signinWithAccountItem:accountItem
     accountPassword:password
     completionBlock:^{
         self.isSignin = YES;
         self.error = nil;
    }
     failureBlock:^(NSError *error) {
         self.isSignin = NO;
         self.error = error;
    }];
}

@end
