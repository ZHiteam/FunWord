//
//  AppDelegate.m
//  FunWord
//
//  Created by admin on 14-12-21.
//  Copyright (c) 2014年 funword. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "AuthorHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self ssoSetting];

    RootViewController* rootVC = [[RootViewController alloc]init];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = rootVC;
    self.window = window;
    [self.window makeKeyAndVisible];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    return [ShareSDK handleOpenURL:url
//                 sourceApplication:sourceApplication
//                        annotation:annotation
//                        wxDelegate:nil];
    return [AuthorHelper handleUrl:url];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return [ShareSDK handleOpenURL:url wxDelegate:nil];
    return [AuthorHelper handleUrl:url];
}

-(void)ssoSetting{
    
    [AuthorHelper registerWeiboWithAppKey:@"2887881461"
                                appSecret:@"7a3eb3bf35ebe97de323db25e4f65543"
                              redirectUri:@"http://sns.whalecloud.com/sina2/callback"];
    
    
//    [ShareSDK registerApp:@"562f3fcddae0"];
//    
//    /// 微博
//    [ShareSDK connectSinaWeiboWithAppKey:@"2887881461"
//                               appSecret:@"7a3eb3bf35ebe97de323db25e4f65543"
//                             redirectUri:@"http://sns.whalecloud.com/sina2/callback"];
//    /// 微信
//    [ShareSDK connectWeChatWithAppId:@"wx6e591abe92bbab04"   //微信APPID
//                           appSecret:@"e1251a15fe03039fb586a34ee5df1a8a"  //微信APPSecret
//                           wechatCls:[WXApi class]];
//    
//    ///QQ 41CFA5D3
//    [ShareSDK connectQQWithQZoneAppKey:@"1104127443"
//                     qqApiInterfaceCls:[QQApiInterface class]
//                       tencentOAuthCls:[TencentOAuth class]];
    
}

@end
