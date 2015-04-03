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

@property (weak, nonatomic) IBOutlet UIView *addContactButtonView;

@property (weak, nonatomic) IBOutlet UIView *startTalkButtonView;

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

- (void)setAddContactButtonHidden:(BOOL)isHidden {
    __block NSLayoutConstraint *heightConstraint;
    [self.addContactButtonView.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *obj, NSUInteger idx, BOOL *stop) {
        if (obj.firstAttribute == NSLayoutAttributeHeight) {
            heightConstraint = obj;
        }
    }];
    if (isHidden) {
        self.addContactButtonView.hidden = YES;
        heightConstraint.constant = 0.0;
    }
    else {
        self.addContactButtonView.hidden = NO;
        heightConstraint.constant = 60.0;
    }
}

- (void)setStartTalkButtonHidden:(BOOL)isHidden {
    __block NSLayoutConstraint *heightConstraint;
    [self.startTalkButtonView.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *obj, NSUInteger idx, BOOL *stop) {
        if (obj.firstAttribute == NSLayoutAttributeHeight) {
            heightConstraint = obj;
        }
    }];
    if (isHidden) {
        self.startTalkButtonView.hidden = YES;
        heightConstraint.constant = 0.0;
    }
    else {
        self.startTalkButtonView.hidden = NO;
        heightConstraint.constant = 60.0;
    }
}

#pragma mark - Events

- (IBAction)handleAddContactButtonTapped:(id)sender {
    [self.eventHandler addContact];
}

- (IBAction)handleStartTalkButtonTapped:(id)sender {
    [self.eventHandler startTalk];
}

@end
