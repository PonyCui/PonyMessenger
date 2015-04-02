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

- (void)setUserID:(NSNumber *)userID {
    _userID = userID;
    [self requestUserInformation];
}

- (void)requestUserInformation {
    [[UserCore userManager] fetchUserInformationWithUserID:self.userID forceUpdate:YES completionBlock:^(PPMUserItem *item) {
        self.userItem = item;
        self.titleString = item.nickname;
        self.descriptionString = @"";
        [self requestIconImage];
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

@end
