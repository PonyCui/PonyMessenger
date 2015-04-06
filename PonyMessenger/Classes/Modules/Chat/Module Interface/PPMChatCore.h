//
//  PPMChatCore.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPMChatWireframe.h"

@class PPMChatDataManager;

@interface PPMChatCore : NSObject

@property (nonatomic, readonly) PPMChatWireframe *wireframe;

@property (nonatomic, strong) PPMChatDataManager *dataManager;

@end
