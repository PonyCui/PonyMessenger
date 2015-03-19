//
//  PPMChatContactTableViewCell.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPMChatContactCellPresenter;

@interface PPMChatContactTableViewCell : UITableViewCell

@property (nonatomic, strong) PPMChatContactCellPresenter *eventHandler;

- (void)setIconImage:(UIImage *)iconImage;

- (void)setTitleText:(NSString *)text;

@end
