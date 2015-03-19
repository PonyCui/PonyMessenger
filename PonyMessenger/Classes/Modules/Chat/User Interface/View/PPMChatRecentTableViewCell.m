//
//  PPMChatRecentTableViewCell.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatRecentTableViewCell.h"
#import "PPMChatRecentCellPresenter.h"

@interface PPMChatRecentTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation PPMChatRecentTableViewCell

- (void)awakeFromNib {
    self.eventHandler = [[PPMChatRecentCellPresenter alloc] init];
    self.eventHandler.userInterface = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setIconImage:(UIImage *)iconImage {
    self.iconImageView.image = iconImage;
}

- (void)setTitleText:(NSString *)text {
    self.titleLabel.text = text;
}

- (void)setDescriptionText:(NSString *)text {
    self.descriptionLabel.text = text;
}

- (void)setTimeDate:(NSDate *)date {
}

@end
