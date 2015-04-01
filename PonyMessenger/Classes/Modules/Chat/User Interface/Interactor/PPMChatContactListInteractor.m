//
//  PPMChatContactListInteractor.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-19.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatContactListInteractor.h"
#import "PPMApplication.h"
#import "PPMUserRelationItem.h"
#import "PPMUserItem.h"
#import "PPMChatContactCellInteractor.h"

@interface PPMChatContactListInteractor () {
    BOOL _isFinding;
}

@property (nonatomic, copy) NSSet *contactUserIDSet;

@end

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
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handlePPMUserInformationUpdatedNotification:)
                                                     name:kPPMUserInformationUpdatedNotification
                                                   object:nil];
    }
    return self;
}

- (void)findContacts {
    if (_isFinding) {
        return;
    }
    _isFinding = YES;
    NSMutableArray *userIDS = [NSMutableArray array];
    [[UserCore userManager] fetchUserRelationsWithCompletionBlock:^(NSArray *items) {
        _isFinding = NO;
        [items enumerateObjectsUsingBlock:^(PPMUserRelationItem *obj, NSUInteger idx, BOOL *stop) {
            [userIDS addObject:obj.toUserID];
        }];
        self.contactUserIDSet = [NSSet setWithArray:[userIDS copy]];
        [[UserCore userManager] fetchUserInformationWithUserIDArray:[userIDS copy] forceUpdate:NO completionBlock:^(NSArray *items) {
            NSMutableArray *contacts = [NSMutableArray array];
            [items enumerateObjectsUsingBlock:^(PPMUserItem *obj, NSUInteger idx, BOOL *stop) {
                PPMChatContactCellInteractor *cellInteractor = [[PPMChatContactCellInteractor alloc] initWithUserItem:obj];
                [contacts addObject:cellInteractor];
            }];
            self.contacts = [contacts sortedArrayWithOptions:kNilOptions
                                             usingComparator:^NSComparisonResult(PPMChatContactCellInteractor *obj1, PPMChatContactCellInteractor *obj2) {
                                                 if ([obj1.letter isEqualToString:obj2.letter]) {
                                                     return NSOrderedSame;
                                                 }
                                                 else {
                                                     return obj1.letter.hash > obj2.letter.hash ? NSOrderedDescending : NSOrderedAscending;
                                                 }
            }];
        }];
    }];
}

- (void)handlePPMUserInformationUpdatedNotification:(NSNotification *)sender {
    if ([sender.object isKindOfClass:[PPMUserItem class]]) {
        if ([self.contactUserIDSet containsObject:[(PPMUserItem *)sender.object userID]]) {
            [self findContacts];
        }
    }
}

@end
