//
//  PPMSyncItem.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPMSyncItem;

typedef void(^PPMSyncItemSyncingBlock)(PPMSyncItem *syncItem);

@interface PPMSyncItem : NSObject

/**
 *  @brief 同步序列标识
 */
@property (nonatomic, copy) NSString *syncID;

/**
 *  @brief 同步请求执行代码
 *  同步操作完成后，需要把syncItem的eTag变更为最新的信息
 */
@property (nonatomic, copy) PPMSyncItemSyncingBlock syncingBlock;

/**
 *  @brief 同步位置标识，服务器将使用此标识判断需要下发哪些数据
 */
@property (nonatomic, copy) NSString *eTag;

- (void)setSyncingBlock:(PPMSyncItemSyncingBlock)syncingBlock;

- (void)doSync;

@end
