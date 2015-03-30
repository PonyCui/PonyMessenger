//
//  PPMAccountSigninInteractor.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPMAccountSigninInteractor : NSObject

/**
 *  @brief 登录成功标记
 */
@property (nonatomic, assign) BOOL isSignin;

/**
 *  @brief 登录失败原因
 */
@property (nonatomic, strong) NSError *error;

/**
 *  @brief 执行登录操作
 *
 *  @param email    Email
 *  @param password Password
 */
- (void)signinWithEmail:(NSString *)email password:(NSString *)password;

@end
