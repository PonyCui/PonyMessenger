//
//  PPMChatContactListInteractor.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-19.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatContactListInteractor.h"
#import "PPMApplication.h"

@implementation PPMChatContactListInteractor

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(findContacts)
                                                     name:kPPMUserRelationUpdatedNotification
                                                   object:nil];
    }
    return self;
}

- (void)findContacts {
    
}

@end
