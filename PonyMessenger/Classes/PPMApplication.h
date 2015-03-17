//
//  PPMApplication.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPMDefines.h"
#import "PPMCore.h"

@interface PPMApplication : NSObject

+ (PPMApplication *)sharedApplication;

@property (nonatomic, readonly) PPMCore *core;

@end
