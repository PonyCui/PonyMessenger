//
//  PPMChatManager.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/3.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatMessageManager.h"
#import <PonyChatUI/PCUApplication.h>

@implementation PPMChatMessageManager

+ (void)load {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleUIApplicationDidFinishLaunchingNotification)
     name:UIApplicationDidFinishLaunchingNotification
     object:nil];
}

+ (void)handleUIApplicationDidFinishLaunchingNotification {
    [PCUApplication setMessageManagerClass:[PPMChatMessageManager class]];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self connect];
    }
    return self;
}

- (void)connect {
    
}

- (void)disconnect {
    
}

- (void)sendMessage:(PCUMessage *)message {
    
}

@end
