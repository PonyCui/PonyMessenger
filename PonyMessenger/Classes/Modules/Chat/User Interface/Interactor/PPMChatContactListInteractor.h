//
//  PPMChatContactListInteractor.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-19.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPMChatContactListInteractor : NSObject

/**
 *  NSArray -> NSArray(Section) -> PPMChatContactCellInteractor
 */
@property (nonatomic, copy) NSArray *contacts;

- (void)findContacts;

@end
