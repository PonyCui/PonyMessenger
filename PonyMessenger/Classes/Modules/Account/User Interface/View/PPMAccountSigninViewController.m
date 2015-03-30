//
//  PPMAccountSigninViewController.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-29.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMAccountSigninViewController.h"

@interface PPMAccountSigninViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation PPMAccountSigninViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViewStyles];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handldUITextFieldTextDidChangeNotification)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.scrollViewWidthConstraint.constant = CGRectGetWidth(self.view.bounds);
    self.scrollViewHeightConstraint.constant = CGRectGetHeight(self.view.bounds) - [self.topLayoutGuide length] + 1.0;
}

- (void)configureViewStyles {
    self.emailView.layer.cornerRadius = 4.0;
    self.emailView.layer.borderWidth = 1.0f;
    self.emailView.layer.borderColor = [UIColor colorWithRed:214.0/255.0
                                                       green:214.0/255.0
                                                        blue:214.0/255.0
                                                       alpha:1.0].CGColor;
    self.passwordView.layer.cornerRadius = 4.0;
    self.passwordView.layer.borderWidth = 1.0f;
    self.passwordView.layer.borderColor = [UIColor colorWithRed:214.0/255.0
                                                       green:214.0/255.0
                                                        blue:214.0/255.0
                                                       alpha:1.0].CGColor;
    self.actionButton.layer.cornerRadius = 4.0;
    self.actionButton.layer.borderWidth = 1.0f;
    self.actionButton.layer.borderColor = [UIColor colorWithRed:78.0/255.0
                                                          green:200.0/255.0
                                                           blue:78.0/255.0
                                                          alpha:1.0].CGColor;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
    }
    return YES;
}

- (void)handldUITextFieldTextDidChangeNotification {
    if (self.emailTextField.text.length && self.passwordTextField.text.length) {
        [self setActionButtonEnabled:YES];
    }
    else {
        [self setActionButtonEnabled:NO];
    }
}

#pragma mark - Events

- (IBAction)handleViewTapped:(id)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (IBAction)handleCancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - actionButton

- (void)setActionButtonEnabled:(BOOL)enabled {
    [self.actionButton setEnabled:enabled];
    if (enabled) {
        [self.actionButton setBackgroundColor:[UIColor colorWithRed:85.0/255.0
                                                              green:200.0/255.0
                                                               blue:85.0/255.0
                                                              alpha:1.0]];
    }
    else {
        [self.actionButton setBackgroundColor:[UIColor colorWithRed:100.0/255.0
                                                              green:211.0/255.0
                                                               blue:100.0/255.0
                                                              alpha:1.0]];
    }
}

@end
