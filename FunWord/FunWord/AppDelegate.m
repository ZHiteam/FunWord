//
//  AppDelegate.m
//  FunWord
//
//  Created by admin on 14-12-21.
//  Copyright (c) 2014年 funword. All rights reserved.
//

#import "AppDelegate.h"
#import "FWFirstVC.h"
#import "FWSecondVC.h"
#import "FWThirdVC.h"
#import "FWFouthVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    FECustomTabBarController*tabBarVC = [[FECustomTabBarController alloc] init];
    
    FWFirstVC *firstVC = [[FWFirstVC alloc] init];
    UINavigationController *firstNaviVC  = [[UINavigationController alloc] initWithRootViewController:firstVC];
    
    FWSecondVC *secondVC = [[FWSecondVC alloc] init];
    UINavigationController *secondNaviVC = [[UINavigationController alloc] initWithRootViewController:secondVC];
    
    FWThirdVC *thirdVC = [[FWThirdVC alloc] init];
    UINavigationController *thirdNaviVC = [[UINavigationController alloc] initWithRootViewController:thirdVC];
    
    FWFouthVC *fourth = [[FWFouthVC alloc] init];
    UINavigationController *fourthNaviVC = [[UINavigationController alloc] initWithRootViewController:fourth];
    
    [tabBarVC setViewControllers:@[firstNaviVC,secondNaviVC,thirdNaviVC,fourthNaviVC]];
    [tabBarVC setSelectedIndex:0];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = tabBarVC;
    self.window = window;
    [self.window makeKeyAndVisible];
    
    UINavigationBar *naviBar = [UINavigationBar appearance];
    [naviBar setBarTintColor:FERGB(0x2e, 0x39, 0x48, 1.0)];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [naviBar setTitleTextAttributes:attributes];
    
    
    return YES;
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
