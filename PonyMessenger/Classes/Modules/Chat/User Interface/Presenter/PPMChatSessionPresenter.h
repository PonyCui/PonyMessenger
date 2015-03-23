//
//  PPMChatSessionPresenter.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMChatSessionViewController, PPMChatSessionInteractor;

@interface PPMChatSessionPresenter : NSObject

@property (nonatomic, weak) PPMChatSessionViewController *userInterface;

@property (nonatomic, strong) PPMChatSessionInteractor *sessionInteractor;

- (void)updateView;

@end
