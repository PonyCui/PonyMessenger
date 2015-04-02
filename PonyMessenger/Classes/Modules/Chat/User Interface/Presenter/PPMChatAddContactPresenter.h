//
//  PPMChatAddContactPresenter.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/2.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMChatAddContactViewController;

@interface PPMChatAddContactPresenter : NSObject

@property (nonatomic, weak) PPMChatAddContactViewController *userInterface;

- (void)doSearch;

@end
