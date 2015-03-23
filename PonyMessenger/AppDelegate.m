//
//  AppDelegate.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "AppDelegate.h"
#import "PPMApplication.h"
#import <PonyChatUI/PCUApplication.h>
#import <PonyChatUI/PCUSender.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    if ([self.window.rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        [tabBarController setViewControllers:@[]];
        [[[[[PPMApplication sharedApplication] core] chatCore] wireframe]
         presentRecentViewControllerToTabBarController:tabBarController];
        [[[[[PPMApplication sharedApplication] core] chatCore] wireframe]
         presentContactViewControllerToTabBarController:tabBarController];
    }
    [self configureSender];
    return YES;
}

- (void)configureSender {
    PCUSender *sender = [[PCUSender alloc] init];
    sender.identifier = @"1";
    sender.thumbURLString = @"http://tp3.sinaimg.cn/1642351362/180/5708018784/0";
    sender.title = @"Pony";
    [PCUApplication setSender:sender];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
