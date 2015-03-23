//
//  PPMChatSessionViewController.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPMChatSessionPresenter;

@interface PPMChatSessionViewController : UIViewController

@property (nonatomic, strong) PPMChatSessionPresenter *eventHandler;

@end
