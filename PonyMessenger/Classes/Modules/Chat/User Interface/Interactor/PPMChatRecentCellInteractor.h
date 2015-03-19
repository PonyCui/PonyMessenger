//
//  PPMChatRecentCellInteractor.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PPMChatRecentCellInteractor : NSObject

/**
 *  @brief 头像
 */
@property (nonatomic, strong) UIImage *iconImage;

/**
 *  @brief 昵称
 */
@property (nonatomic, copy) NSString *nickname;

/**
 *  @brief 最后一条交谈内容
 */
@property (nonatomic, copy) NSString *recentTalk;

/**
 *  @brief 最后一条交谈内容的时间
 */
@property (nonatomic, strong) NSDate *recentDate;

@end
