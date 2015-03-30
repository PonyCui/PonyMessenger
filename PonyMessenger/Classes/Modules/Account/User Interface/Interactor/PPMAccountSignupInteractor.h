//
//  PPMAccountSignupInteractor.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPMAccountSignupInteractor : NSObject

/**
 *  @brief 注册成功标记
 */
@property (nonatomic, assign) BOOL isSignup;

/**
 *  @brief 注册失败原因
 */
@property (nonatomic, strong) NSError *error;

/**
 *  @brief 执行注册操作
 *
 *  @param email
 *  @param password
 */
- (void)signupWithEmail:(NSString *)email password:(NSString *)password;

@end
