//
//  PPMChatAddContactViewController.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/2.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPMChatAddContactPresenter;

@interface PPMChatAddContactViewController : UIViewController

@property (nonatomic, strong) PPMChatAddContactPresenter *eventHandler;

@property (weak, nonatomic) IBOutlet UITextField *keyboardTextField;

- (void)showLoadingHUD;

- (void)hideLoadingHUD;

- (void)showErrorWithDescription:(NSString *)description;

@end
