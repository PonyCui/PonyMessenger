//
//  PPMSyncManager.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMSyncItem;

@interface PPMSyncManager : NSObject

- (void)addItem:(PPMSyncItem *)item;

@end
