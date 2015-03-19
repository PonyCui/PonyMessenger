//
//  PPMChaatContactListPresenter.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-19.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMChatContactViewController, PPMChatContactListInteractor;

@interface PPMChatContactListPresenter : NSObject

@property (nonatomic, weak) PPMChatContactViewController *userInterface;

@property (nonatomic, strong) PPMChatContactListInteractor *listInteractor;

- (void)updateView;

@end
