//
//  ChatSession.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/4.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMManagedChatSessionItem.h"
#import "PPMChatSessionItem.h"

@implementation PPMManagedChatSessionItem

@dynamic session_id;
@dynamic session_type;
@dynamic session_icon;
@dynamic session_last_post;
@dynamic session_last_update;
@dynamic session_title;

- (void)setItem:(PPMChatSessionItem *)item {
    self.session_id = item.sessionID;
    self.session_type = item.sessionType;
    self.session_title = item.sessionTitle;
    self.session_icon = item.sessionIcon;
    self.session_last_update = item.sessionLastUpdate;
    self.session_last_post = item.sessionLastPost;
}

@end
