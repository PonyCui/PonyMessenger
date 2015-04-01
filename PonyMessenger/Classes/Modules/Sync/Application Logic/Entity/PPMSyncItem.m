//
//  PPMSyncItem.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMSyncItem.h"

@implementation PPMSyncItem

- (void)doSync {
    self.syncingBlock(self);
}

@end
