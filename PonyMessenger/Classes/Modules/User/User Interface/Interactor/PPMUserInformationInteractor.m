//
//  PPMUserInformationInteractor.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/2.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMUserInformationInteractor.h"
#import "PPMApplication.h"
#import "PPMUserItem.h"
#import "PPMUserRelationItem.h"
#import <AFNetworking/AFNetworking.h>

@interface PPMUserInformationInteractor ()

@property (nonatomic, strong) PPMUserItem *userItem;

@end

@implementation PPMUserInformationInteractor

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handlePPMUserInformationUpdatedNotification:)
                                                     name:kPPMUserInformationUpdatedNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handlePPMUserRelationUpdatedNotification:)
                                                     name:kPPMUserRelationUpdatedNotification
                                                   object:nil];
    }
    return self;
}

- (void)handlePPMUserInformationUpdatedNotification:(NSNotification *)sender {
    if ([sender.object isKindOfClass:[PPMUserItem class]]) {
        if ([[(PPMUserItem *)sender.object userID] isEqualToNumber:self.userID]) {
            [self requestUserInformation];
        }
    }
}

- (void)handlePPMUserRelationUpdatedNotification:(NSNotification *)sender {
    if ([sender.object isKindOfClass:[PPMUserRelationItem class]]) {
        if ([[(PPMUserRelationItem *)sender.object toUserID] isEqualToNumber:self.userID]) {
            [self requestRelation];
        }
    }
}

- (void)setUserID:(NSNumber *)userID {
    _userID = userID;
    [self requestUserInformation];
}

- (void)requestUserInformation {
    [[UserCore userManager] fetchUserInformationWithUserID:self.userID forceUpdate:YES completionBlock:^(PPMUserItem *item) {
        if (item != nil) {
            self.userItem = item;
            self.titleString = item.nickname;
            self.descriptionString = @"";
            [self requestIconImage];
            [self requestRelation];
        }
    }];
}

- (void)requestIconImage {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.userItem.avatarURLString]
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                         timeoutInterval:60.0];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer.acceptableContentTypes = nil;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            self.avatarImage = [UIImage imageWithData:responseObject];
        }
    } failure:nil];
    [[[AFHTTPRequestOperationManager manager] operationQueue] addOperation:operation];
}

- (void)requestRelation {
    [[UserCore userManager] fetchUserRelationToUserID:self.userID completionBlock:^(PPMUserRelationItem *item) {
        self.isFriend = item != nil;
    }];
}

- (void)addRelationWithCompletionBlock:(void (^)(BOOL))completionBlock failureBlock:(void (^)(NSError *))failureBlock {
    [[UserCore userManager] addUserRelationToUserID:self.userID completionBlock:^(BOOL needUserAgree) {
        if (completionBlock) {
            completionBlock(needUserAgree);
        }
    } failureBlock:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end
