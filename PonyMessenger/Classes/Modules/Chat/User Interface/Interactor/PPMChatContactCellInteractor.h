//
//  PPMChatContactCellInteractor.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-19.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PPMUserItem;

@interface PPMChatContactCellInteractor : NSObject

/**
 *  @brief 分类字母
 */
@property (nonatomic, copy) NSString *letter;

/**
 *  @brief 昵称
 */
@property (nonatomic, copy) NSString *nickname;

/**
 *  @brief 头像
 */
@property (nonatomic, strong) UIImage *iconImage;

- (instancetype)initWithUserItem:(PPMUserItem *)userItem;

@end
