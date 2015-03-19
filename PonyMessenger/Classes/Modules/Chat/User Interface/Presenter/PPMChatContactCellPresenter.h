//
//  PPMChatContactCellPresenter.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-19.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMChatContactCellInteractor, PPMChatContactTableViewCell;

@interface PPMChatContactCellPresenter : NSObject

@property (nonatomic, weak) PPMChatContactTableViewCell *userInterface;

@property (nonatomic, strong) PPMChatContactCellInteractor *cellInteractor;

- (void)updateView;

@end
