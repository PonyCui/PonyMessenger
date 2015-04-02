//
//  PPMUserInformationViewController.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/2.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMUserInformationViewController.h"
#import "PPMUserInformationPresenter.h"

@interface PPMUserInformationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PPMUserInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.eventHandler updateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Render

- (void)setAvatarImage:(UIImage *)image {
    self.avatarImageView.image = image;
}

- (void)setTitleText:(NSString *)text {
    self.titleLabel.text = text;
}

@end
