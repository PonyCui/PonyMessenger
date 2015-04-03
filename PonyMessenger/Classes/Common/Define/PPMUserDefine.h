//
//  PPMUserDefine.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/31.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPPMUserInformationUpdatedNotification @"PPMUserInformationUpdatedNotification"
#define kPPMUserRelationUpdatedNotification @"PPMUserRelationUpdatedNotification"

@interface PPMUserDefine : NSObject

@property (nonatomic, readonly) NSTimeInterval infoCacheTimeout;

@property (nonatomic, readonly) NSString *infoURLString;

@property (nonatomic, readonly) NSDictionary *infoResponseEagerTypes;

@property (nonatomic, readonly) NSString *infosURLString;

@property (nonatomic, readonly) NSDictionary *infosResponseEagerTypes;

@property (nonatomic, readonly) NSString *relationsURLString;

@property (nonatomic, readonly) NSDictionary *relationsResponseEagerTypes;

@property (nonatomic, readonly) NSString *relationAddURLString;

@property (nonatomic, readonly) NSDictionary *relationAddResponseEagerTypes;

@property (nonatomic, readonly) NSString *searchURLString;

@property (nonatomic, readonly) NSDictionary *searchResponseEagerTypes;

@end
