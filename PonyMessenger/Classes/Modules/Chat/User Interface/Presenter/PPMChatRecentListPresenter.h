//
//  PPMChatRecentListPresenter.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMChatRecentViewController, PPMChatRecentListInteractor;

@interface PPMChatRecentListPresenter : NSObject

@property (nonatomic, weak) PPMChatRecentViewController *userInterface;

@property (nonatomic, strong) PPMChatRecentListInteractor *listInteractor;

- (void)updateView;

@end
