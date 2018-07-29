//
//  AppDelegate.m
//  FZDJapp
//
//  Created by FZYG on 2018/6/14.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "AppDelegate.h"
#import "FZDJMainVCL.h"
#import "FXBaseNavigationController.h"
#import <PPNetworkHelper/PPNetworkHelper.h>
#import "FZDJDataModelSingleton.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    FZDJMainVCL *mainVCL = [[FZDJMainVCL alloc] init];
    
    FXBaseNavigationController *navigationController = [[FXBaseNavigationController alloc]
        initWithRootViewController:mainVCL];
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[FZDJDataModelSingleton sharedInstance] save];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
