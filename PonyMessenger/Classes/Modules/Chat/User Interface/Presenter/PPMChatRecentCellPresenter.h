//
//  PPMChatRecentCellPresenter.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PPMChatRecentTableViewCell, PPMChatRecentCellInteractor;

@interface PPMChatRecentCellPresenter : NSObject

@property (nonatomic, weak) PPMChatRecentTableViewCell *userInterface;

@property (nonatomic, strong) PPMChatRecentCellInteractor *cellInteractor;

- (void)updateView;

- (void)presentChatViewControllerToNavigationController:(UINavigationController *)navigationController;

@end
