//
//  PPMChatContactTableViewCell.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatContactTableViewCell.h"
#import "PPMChatContactCellPresenter.h"

@interface PPMChatContactTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PPMChatContactTableViewCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.eventHandler = [[PPMChatContactCellPresenter alloc] init];
        self.eventHandler.userInterface = self;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
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

@end
