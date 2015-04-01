//
//  PPMSyncTestService.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/1.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMSyncTestService.h"
#import "PPMValueFormatter.h"

@implementation PPMSyncTestService

- (void)test:(id)params {
    NSLog(@"Test Service - Test Method - Params->text:%@", TODictionary(params)[@"text"]);
}

@end
