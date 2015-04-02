//
//  PPMUserCore.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/3/30.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPMUserManager.h"
#import "PPMUserWireframe.h"

@interface PPMUserCore : NSObject

@property (nonatomic, readonly) PPMUserManager *userManager;

@property (nonatomic, readonly) PPMUserWireframe *wireframe;

@end
