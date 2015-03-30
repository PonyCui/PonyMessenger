//
//  PPMAccountSignupPresenter.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMAccountSignupViewController;

@interface PPMAccountSignupPresenter : NSObject

@property (nonatomic, weak) PPMAccountSignupViewController *userInterface;

- (void)signup;

@end
