//
//  ChatRecord.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/3.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMManagedChatRecordItem.h"
#import "PPMChatRecordItem.h"

@implementation PPMManagedChatRecordItem

@dynamic record_id;
@dynamic session_id;
@dynamic from_user_id;
@dynamic record_time;
@dynamic record_type;
@dynamic record_title;
@dynamic record_params;
@dynamic record_hash;

- (void)setItem:(PPMChatRecordItem *)item {
    self.record_id = item.recordID;
    self.session_id = item.sessionID;
    self.from_user_id = item.fromUserID;
    self.record_time = item.recordTime;
    self.record_type = item.recordType;
    self.record_title = item.recordTitle;
    self.record_params = item.recordParams;
    self.record_hash = item.recordHash;
}

@end
