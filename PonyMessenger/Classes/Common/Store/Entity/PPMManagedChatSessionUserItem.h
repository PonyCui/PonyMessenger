//
//  PPMManagedChatSessionUserItem.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-4-12.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface PPMManagedChatSessionUserItem : NSManagedObject

@property (nonatomic, retain) NSNumber *session_id;

@property (nonatomic, retain) NSNumber *user_id;

@end
