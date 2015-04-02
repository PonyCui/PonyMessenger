//
//  PPMChatAddContactPresenter.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/2.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatAddContactPresenter.h"
#import "PPMChatAddContactInteractor.h"
#import "PPMChatAddContactViewController.h"
#import "PPMApplication.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface PPMChatAddContactPresenter ()

@property (nonatomic, strong) PPMChatAddContactInteractor *addContactInteractor;

@end

@implementation PPMChatAddContactPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _addContactInteractor = [[PPMChatAddContactInteractor alloc] init];
        [self configureReactiveCocoa];
    }
    return self;
}

- (void)doSearch {
    [self.addContactInteractor findUsersWithKeyword:self.userInterface.keyboardTextField.text];
}

- (void)configureReactiveCocoa {
    @weakify(self);
    [RACObserve(self, addContactInteractor.isRequesting) subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.addContactInteractor.isRequesting) {
                [self.userInterface showLoadingHUD];
            }
            else {
                [self.userInterface hideLoadingHUD];
            }
        });
    }];
    [RACObserve(self, addContactInteractor.userIDS) subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.addContactInteractor.userIDS count] > 0) {
                [[UserCore wireframe] presentUserInformationViewControllerToNavigationController:self.userInterface.navigationController withUserID:[self.addContactInteractor.userIDS firstObject]];
            }
            else if(self.addContactInteractor.error != nil){
                [self.userInterface showErrorWithDescription:self.addContactInteractor.error.localizedDescription];
            }
        });
    }];
}

@end
