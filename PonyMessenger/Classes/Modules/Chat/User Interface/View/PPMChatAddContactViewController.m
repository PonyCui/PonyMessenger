//
//  PPMChatAddContactViewController.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/2.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatAddContactViewController.h"
#import "PPMChatAddContactPresenter.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface PPMChatAddContactViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) MBProgressHUD *loadingHUD;

@end

@implementation PPMChatAddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.keyboardTextField becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length) {
        [self.eventHandler doSearch];
    }
    return YES;
}

#pragma mark - HUD

- (void)showLoadingHUD {
    self.loadingHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideLoadingHUD {
    [self.loadingHUD hide:YES];
}

- (void)showErrorWithDescription:(NSString *)description {
    if (description.length) {
        [self.loadingHUD hide:NO];
        MBProgressHUD *errorHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [errorHUD setMode:MBProgressHUDModeText];
        [errorHUD setLabelText:description];
        [errorHUD hide:YES afterDelay:1.5];
    }
}

@end
