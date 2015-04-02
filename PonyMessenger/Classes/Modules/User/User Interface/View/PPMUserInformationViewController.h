//
//  PPMUserInformationViewController.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/2.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPMUserInformationPresenter;

@interface PPMUserInformationViewController : UITableViewController

@property (nonatomic, strong) PPMUserInformationPresenter *eventHandler;

@property (nonatomic, strong) NSNumber *userID;

- (void)setAvatarImage:(UIImage *)image;

- (void)setTitleText:(NSString *)text;

- (void)setAddContactButtonHidden:(BOOL)isHidden;

@end
