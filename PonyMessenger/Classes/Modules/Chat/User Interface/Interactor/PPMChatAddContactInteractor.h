//
//  PPMChatAddContactInteractor.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/2.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPMChatAddContactInteractor : NSObject

@property (nonatomic, assign) BOOL isRequesting;

@property (nonatomic, strong) NSError *error;

/**
 *  NSArray -> NSNumber
 */
@property (nonatomic, strong) NSArray *userIDS;

- (void)findUsersWithKeyword:(NSString *)keyword;

@end
