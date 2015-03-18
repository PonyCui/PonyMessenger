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

@property (nonatomic, strong) UIImage *iconImage;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *recentTalk;

@property (nonatomic, strong) NSDate *recentDate;

@end
