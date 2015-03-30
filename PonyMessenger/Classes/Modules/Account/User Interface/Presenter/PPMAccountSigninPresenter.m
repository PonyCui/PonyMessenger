//
//  PPMAccountSigninPresenter.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMAccountSigninPresenter.h"
#import "PPMAccountSigninInteractor.h"
#import "PPMAccountSigninViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface PPMAccountSigninPresenter ()

@property (nonatomic, strong) PPMAccountSigninInteractor *signinInteractor;

@end

@implementation PPMAccountSigninPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _signinInteractor = [[PPMAccountSigninInteractor alloc] init];
        [self configureReactiveCocoa];
    }
    return self;
}

- (void)signin {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self.userInterface showLoadingHUD];
    [self.signinInteractor signinWithEmail:self.userInterface.emailTextField.text
                                  password:self.userInterface.passwordTextField.text];
}

- (void)configureReactiveCocoa {
    @weakify(self);
    [RACObserve(self, signinInteractor.isSignin) subscribeNext:^(id x) {
        @strongify(self);
        if (self.signinInteractor.isSignin) {
            NSLog(@"isSignin");
        }
        [self.userInterface hideLoadingHUD];
    }];
    [RACObserve(self, signinInteractor.error) subscribeNext:^(id x) {
        @strongify(self);
        [self.userInterface showErrorWithDescription:self.signinInteractor.error.localizedDescription];
        [self.userInterface hideLoadingHUD];
    }];
}

@end
