//
//  ChatRecord.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/3.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PPMChatRecordItem;

@interface PPMManagedChatRecordItem : NSManagedObject

@property (nonatomic, retain) NSNumber * record_id;
@property (nonatomic, retain) NSNumber * session_id;
@property (nonatomic, retain) NSNumber * from_user_id;
@property (nonatomic, retain) NSNumber * record_time;
@property (nonatomic, retain) NSNumber * record_type;
@property (nonatomic, retain) NSString * record_title;
@property (nonatomic, retain) NSString * record_params;
@property (nonatomic, retain) NSString * record_hash;

- (void)setItem:(PPMChatRecordItem *)item;

@end
