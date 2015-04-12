//
//  PPMChatSessionInteractor.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PCUChat, PPMChatSessionItem;

@interface PPMChatSessionInteractor : NSObject

@property (nonatomic, strong) PCUChat *chatItem;

@property (nonatomic, strong) PPMChatSessionItem *sessionItem;

@property (nonatomic, copy) NSString *sessionTitle;

- (void)requestSessionItem;

@end
