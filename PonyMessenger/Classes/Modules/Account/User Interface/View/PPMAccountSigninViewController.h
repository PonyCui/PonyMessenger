//
//  PPMAccountSigninViewController.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-29.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPMAccountSigninPresenter;

@interface PPMAccountSigninViewController : UIViewController

@property (nonatomic, strong) PPMAccountSigninPresenter *eventHandler;

#pragma mark - IBOutlet
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (void)showLoadingHUD;

- (void)hideLoadingHUD;

- (void)showErrorWithDescription:(NSString *)description;

@end
