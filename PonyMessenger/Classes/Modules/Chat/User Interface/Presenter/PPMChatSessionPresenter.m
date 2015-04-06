//
//  PPMChatSessionPresenter.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatSessionPresenter.h"
#import "PPMChatSessionInteractor.h"
#import "PPMChatSessionViewController.h"
#import <PonyChatUI/PCUApplication.h>

@implementation PPMChatSessionPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sessionInteractor = [[PPMChatSessionInteractor alloc] init];
    }
    return self;
}

- (void)updateView {
    [self.sessionInteractor requestSessionItem];
    [PCU[@protocol(PCUWireframe)] presentChatViewToViewController:self.userInterface
                                                     withChatItem:self.sessionInteractor.chatItem];
}

@end
