//
//  PPMChatContactCellPresenter.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-19.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatContactCellPresenter.h"
#import "PPMChatContactCellInteractor.h"
#import "PPMChatContactTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation PPMChatContactCellPresenter

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
}

@end
