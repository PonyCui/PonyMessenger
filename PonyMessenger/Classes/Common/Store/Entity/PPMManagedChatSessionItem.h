//
//  ChatSession.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/4.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PPMChatSessionItem;

@interface PPMManagedChatSessionItem : NSManagedObject

@property (nonatomic, retain) NSNumber * session_id;

@property (nonatomic, retain) NSNumber * session_type;

@property (nonatomic, retain) NSString * session_title;

@property (nonatomic, retain) NSString * session_icon;

@property (nonatomic, retain) NSNumber * session_last_update;

@property (nonatomic, retain) NSString * session_last_post;

- (void)setItem:(PPMChatSessionItem *)item;

@end
