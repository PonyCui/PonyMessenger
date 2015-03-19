//
//  PPMChatRecentCellInteractor.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatRecentCellInteractor.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface PPMChatRecentCellInteractor ()

@end

@implementation PPMChatRecentCellInteractor

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nickname = [NSString stringWithFormat:@"PonyCui的小号 - %u", arc4random()];
        self.recentTalk = @"春哥你这个逗逼";
        self.recentDate = [NSDate dateWithTimeIntervalSinceNow:-(arc4random() % 8640000)];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://pic3.zhimg.com/5f89bb81b3ca4610e568eca5835ac8da_l.jpg"]];
            self.iconImage = [UIImage imageWithData:imageData];
        });
    }
    return self;
}

@end
