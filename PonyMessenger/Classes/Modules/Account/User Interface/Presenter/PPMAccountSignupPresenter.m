//
//  PPMAccountSignupPresenter.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMAccountSignupPresenter.h"
#import "PPMAccountSignupInteractor.h"
#import "PPMAccountSignupViewController.h"
#import "PPMDefine.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface PPMAccountSignupPresenter ()

@property (nonatomic, strong) PPMAccountSignupInteractor *signupInteractor;

@end

@implementation PPMAccountSignupPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _signupInteractor = [[PPMAccountSignupInteractor alloc] init];
        [self configureReactiveCocoa];
    }
    return self;
}

- (void)signup {
    if ([self.userInterface.passwordTextField.text isEqualToString:self.userInterface.passwordConfirmTextField.text]) {
        [self.userInterface showLoadingHUD];
        [self.signupInteractor signupWithEmail:self.userInterface.emailTextField.text
                                      password:self.userInterface.passwordTextField.text];
    }
    else {
        [self.userInterface showErrorWithDescription:@"Password not same."];
    }
    
}

- (void)configureReactiveCocoa {
    @weakify(self);
    [RACObserve(self, signupInteractor.isSignup) subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.signupInteractor.isSignup) {
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:kPPMAccountSigninCompletionNotification object:nil];
            }
            [self.userInterface hideLoadingHUD];
        });
    }];
    [RACObserve(self, signupInteractor.error) subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.userInterface showErrorWithDescription:self.signupInteractor.error.localizedDescription];
            [self.userInterface hideLoadingHUD];
        });
    }];
}

@end
