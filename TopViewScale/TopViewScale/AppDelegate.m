//
//  AppDelegate.m
//  TopViewScale
//
//  Created by 任波 on 17/3/23.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "AppDelegate.h"
#import "BRHomeViewController.h"
//电池条上网络活动提示(菊花转动)
#import <AFNetworkActivityIndicatorManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    BRHomeViewController *homeVC = [[BRHomeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    /**
        AFN 加载网络图片的使用细节
            1. 如果图片太大，有可能不会缓存
            2. 使用的是系统默认的缓存
        注意：如果用 SDWebImage 加载网络图片，状态栏不会显示指示器。
             使用 YYWebImage 加载网络图片，可以设置状态栏显示指示器。
     */
    
    // 设置状态栏的网络指示器
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
