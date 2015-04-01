//
//  PPMChatContactCellInteractor.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-19.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatContactCellInteractor.h"
#import "PPMUserItem.h"
#import <AFNetworking/AFNetworking.h>

@interface PPMChatContactCellInteractor ()

@property (nonatomic, strong) PPMUserItem *userItem;

@end

@implementation PPMChatContactCellInteractor

- (instancetype)initWithUserItem:(PPMUserItem *)userItem {
    self = [super init];
    if (self && [userItem isKindOfClass:[PPMUserItem class]]) {
        self.userItem = userItem;
        self.nickname = userItem.nickname;
        [self requestIconImage];
    }
    return self;
}

- (void)reqeustLetter {
    
}

- (void)requestIconImage {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.userItem.avatarURLString]
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                         timeoutInterval:60.0];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer.acceptableContentTypes = nil;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            self.iconImage = [UIImage imageWithData:responseObject];
        }
    } failure:nil];
    [[[AFHTTPRequestOperationManager manager] operationQueue] addOperation:operation];
}

@end
