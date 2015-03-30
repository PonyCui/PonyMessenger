//
//  PPMAccountSignupViewController.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPMAccountSignupPresenter;

@interface PPMAccountSignupViewController : UIViewController

@property (nonatomic, strong) PPMAccountSignupPresenter *eventHandler;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmTextField;

- (void)showLoadingHUD;

- (void)hideLoadingHUD;

- (void)showErrorWithDescription:(NSString *)description;


@end
