//
//  PPMChatManager.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/3.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PonyChatUI/PCUMessageManager.h>

@interface PPMChatMessageManager : NSObject

@property (nonatomic, weak) id<PCUMessageManagerDelegate> delegate;

@property (nonatomic, strong) PCUChat *chatItem;

- (void)connect;

- (void)disconnect;

- (void)sendMessage:(PCUMessage *)message;

@end
