//
//  PPMCore.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPMWireframe.h"
#import "PPMChatCore.h"
#import "PPMAccountCore.h"
#import "PPMUserCore.h"
#import "PPMDefine.h"

#define ChatCore [[[PPMApplication sharedApplication] core] chatCore]

#define AccountCore [[[PPMApplication sharedApplication] core] accountCore]

#define UserCore [[[PPMApplication sharedApplication] core] userCore]

@interface PPMCore : NSObject

@property (nonatomic, readonly) PPMWireframe *wireframe;

@property (nonatomic, readonly) PPMChatCore *chatCore;

@property (nonatomic, readonly) PPMAccountCore *accountCore;

@property (nonatomic, readonly) PPMUserCore *userCore;

@end
