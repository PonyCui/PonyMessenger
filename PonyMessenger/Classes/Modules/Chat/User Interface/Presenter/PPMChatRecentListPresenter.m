//
//  PPMChatRecentListPresenter.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatRecentListPresenter.h"
#import "PPMChatRecentListInteractor.h"
#import "PPMChatRecentViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation PPMChatRecentListPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.listInteractor = [[PPMChatRecentListInteractor alloc] init];
        [self configureReactiveCocoa];
    }
    return self;
}

- (void)updateView {
    [self.listInteractor findRecentSessions];
}

- (void)configureReactiveCocoa {
    @weakify(self);
    [RACObserve(self, listInteractor.cellInteractors) subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.userInterface reloadTableView];
        });
    }];
}

@end
