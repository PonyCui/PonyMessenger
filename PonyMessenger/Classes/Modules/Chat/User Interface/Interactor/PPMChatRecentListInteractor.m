//
//  PPMChatRecentListInteractor.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatRecentListInteractor.h"
#import "PPMChatRecentCellInteractor.h"

@implementation PPMChatRecentListInteractor

- (void)findRecentSessions {
    NSMutableArray *cellInteractors = [NSMutableArray array];
    NSInteger i = 100;
    do {
        PPMChatRecentCellInteractor *cellInteractor = [[PPMChatRecentCellInteractor alloc] init];
        [cellInteractors addObject:cellInteractor];
        i--;
    } while (i > 0);
    self.cellInteractors = cellInteractors;
}

@end
