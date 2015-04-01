//
//  PPMCore.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMCore.h"

@interface PPMCore ()

@property (nonatomic, readwrite) PPMWireframe *wireframe;

@property (nonatomic, readwrite) PPMChatCore *chatCore;

@property (nonatomic, readwrite) PPMAccountCore *accountCore;

@property (nonatomic, readwrite) PPMUserCore *userCore;

@property (nonatomic, readwrite) PPMSyncCore *syncCore;

@end

@implementation PPMCore

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)loadAccountCore {
    [self accountCore];
}

- (void)loadSyncCore {
    [[self syncCore] syncManager];
    [[self syncCore] socketServiceManager];
}

#pragma mark - Lazy Load

- (PPMWireframe *)wireframe {
    if (_wireframe == nil) {
        _wireframe = [[PPMWireframe alloc] init];
    }
    return _wireframe;
}

- (PPMChatCore *)chatCore {
    if (_chatCore == nil) {
        _chatCore = [[PPMChatCore alloc] init];
    }
    return _chatCore;
}

- (PPMAccountCore *)accountCore {
    if (_accountCore == nil) {
        _accountCore = [[PPMAccountCore alloc] init];
    }
    return _accountCore;
}

- (PPMUserCore *)userCore {
    if (_userCore == nil) {
        _userCore = [[PPMUserCore alloc] init];
    }
    return _userCore;
}

- (PPMSyncCore *)syncCore {
    if (_syncCore == nil) {
        _syncCore = [[PPMSyncCore alloc] init];
    }
    return _syncCore;
}

@end
