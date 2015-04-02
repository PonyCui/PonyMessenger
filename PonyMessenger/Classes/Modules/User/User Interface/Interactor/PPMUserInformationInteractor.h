//
//  PPMUserInformationInteractor.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/2.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PPMUserInformationIcon) {
    PPMUserInformationIconMale,
    PPMUserInformationIconFemale
};

@interface PPMUserInformationInteractor : NSObject

/**
 *  @brief ...
 */
@property (nonatomic, strong) NSNumber *userID;

/**
 *  @brief YES 已经是好友
 */
@property (nonatomic, assign) BOOL isFriend;

/**
 *  @brief 用户头像
 */
@property (nonatomic, strong) UIImage *avatarImage;

/**
 *  @brief 昵称
 */
@property (nonatomic, copy) NSString *titleString;

/**
 *  @brief 昵称下面那行文件
 */
@property (nonatomic, copy) NSString *descriptionString;

/**
 *  @brief 昵称旁边的图标
 */
@property (nonatomic, copy) NSArray *titleIcons;

@end
