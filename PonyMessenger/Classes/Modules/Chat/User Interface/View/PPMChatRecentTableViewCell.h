//
//  PPMChatRecentTableViewCell.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPMChatRecentCellPresenter;

@interface PPMChatRecentTableViewCell : UITableViewCell

@property (nonatomic, strong) PPMChatRecentCellPresenter *eventHandler;

- (void)setIconImage:(UIImage *)iconImage;

- (void)setTitleText:(NSString *)text;

- (void)setDescriptionText:(NSString *)text;

- (void)setTimeDate:(NSDate *)date;

@end
