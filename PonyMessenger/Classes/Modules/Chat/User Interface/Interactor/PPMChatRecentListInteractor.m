//
//  PPMChatRecentListInteractor.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatRecentListInteractor.h"
#import "PPMChatRecentCellInteractor.h"
#import "PPMApplication.h"
#import "PPMChatDataManager.h"

@implementation PPMChatRecentListInteractor

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self findRecentSessions];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(findRecentSessions)
                                                     name:kPPMChatSessionDidUpdateNotification
                                                   object:nil];
    }
    return self;
}

- (void)findRecentSessions {
//    NSMutableArray *cellInteractors = [NSMutableArray array];
//    NSInteger i = 100;
//    do {
//        PPMChatRecentCellInteractor *cellInteractor = [[PPMChatRecentCellInteractor alloc] init];
//        [cellInteractors addObject:cellInteractor];
//        i--;
//    } while (i > 0);
//    self.cellInteractors = cellInteractors;
    
    [[ChatCore dataManager] findRecentSessionsWithCompletionBlock:^(NSArray *sessions) {
        NSMutableArray *cellInteractors = [NSMutableArray array];
        [sessions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            PPMChatRecentCellInteractor *cellInteractor = [[PPMChatRecentCellInteractor alloc] initWithSessionItem:obj];
            [cellInteractors addObject:cellInteractor];
        }];
        self.cellInteractors = cellInteractors;
    }];
    
}

@end
