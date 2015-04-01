//
//  PPMChatContactCellInteractor.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-19.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatContactCellInteractor.h"
#import "PPMUserItem.h"
#import <PinYin4Objc/PinYin4Objc.h>
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
        [self reqeustLetter];
    }
    return self;
}

- (void)reqeustLetter {
    static NSSet *letterSet;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        letterSet = [NSSet setWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    });
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeUppercase];
    NSString *outputPinyin = [[PinyinHelper toHanyuPinyinStringWithNSString:[self.nickname substringToIndex:1]
                                                withHanyuPinyinOutputFormat:outputFormat
                                                               withNSString:@""] uppercaseString];
    if (outputPinyin.length) {
        outputPinyin = [outputPinyin substringToIndex:1];
    }
    if ([letterSet containsObject:outputPinyin]) {
        self.letter = outputPinyin;
    }
    else {
        self.letter = @"#";
    }
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
