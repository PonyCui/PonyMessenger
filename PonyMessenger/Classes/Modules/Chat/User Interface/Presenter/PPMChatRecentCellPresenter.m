//
//  PPMChatRecentCellPresenter.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatRecentCellPresenter.h"
#import "PPMChatRecentCellInteractor.h"
#import "PPMChatRecentTableViewCell.h"
#import "PPMApplication.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <PonyChatUI/PCUApplication.h>

@implementation PPMChatRecentCellPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureReactiveCocoa];
    }
    return self;
}

- (void)updateView {
    [self.userInterface setIconImage:self.cellInteractor.iconImage];
    [self.userInterface setTitleText:self.cellInteractor.nickname];
    [self.userInterface setDescriptionText:self.cellInteractor.recentTalk];
    [self.userInterface setTimeDate:self.cellInteractor.recentDate];
}

- (void)configureReactiveCocoa {
    @weakify(self);
    [RACObserve(self, cellInteractor.iconImage) subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.userInterface setIconImage:self.cellInteractor.iconImage];
        });
    }];
    [RACObserve(self, cellInteractor.nickname) subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.userInterface setTitleText:self.cellInteractor.nickname];
        });
    }];
    [RACObserve(self, cellInteractor.recentTalk) subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.userInterface setDescriptionText:self.cellInteractor.recentTalk];
        });
    }];
    [RACObserve(self, cellInteractor.recentDate) subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.userInterface setTimeDate:self.cellInteractor.recentDate];
        });
    }];
}

- (void)presentChatViewControllerToNavigationController:(id)navigationController {
    PCUChat *chatItem = [[PCUChat alloc] init];
    chatItem.identifier = @"ChatIdentifier";
    chatItem.title = self.cellInteractor.nickname;
    [[[[[PPMApplication sharedApplication] core] chatCore] wireframe]
     presentSessionViewControllerToNavigationController:navigationController
     withChatItem:chatItem];
    
}

@end
