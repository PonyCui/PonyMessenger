//
//  PPMUserWireframe.h
//  PonyMessenger
//
//  Created by 崔 明辉 on 15/4/2.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PPMUserWireframe : NSObject

- (void)presentUserInformationViewControllerToNavigationController:(UINavigationController *)navigationController
                                                        withUserID:(NSNumber *)userID;

@end
