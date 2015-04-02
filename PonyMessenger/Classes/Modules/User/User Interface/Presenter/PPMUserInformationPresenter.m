//
//  PPMUserInformationPresenter.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/2.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMUserInformationPresenter.h"
#import "PPMUserInformationViewController.h"
#import "PPMUserInformationInteractor.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface PPMUserInformationPresenter ()

@property (nonatomic, strong) PPMUserInformationInteractor *informationInteractor;

@end

@implementation PPMUserInformationPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _informationInteractor = [[PPMUserInformationInteractor alloc] init];
        [self configureReactiveCocoa];
    }
    return self;
}

- (void)updateView {
    self.informationInteractor.userID = self.userInterface.userID;
}

- (void)configureReactiveCocoa {
    @weakify(self);
    [RACObserve(self, informationInteractor.avatarImage) subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.userInterface setAvatarImage:self.informationInteractor.avatarImage];
        });
    }];
    [RACObserve(self, informationInteractor.titleString) subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.userInterface setTitleText:self.informationInteractor.titleString];
        });
    }];
    [RACObserve(self, informationInteractor.isFriend) subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.informationInteractor.isFriend) {
                [self.userInterface setAddContactButtonHidden:YES];
                [self.userInterface setStartTalkButtonHidden:NO];
            }
            else {
                [self.userInterface setAddContactButtonHidden:NO];
                [self.userInterface setStartTalkButtonHidden:YES];
            }
        });
    }];
}

@end
