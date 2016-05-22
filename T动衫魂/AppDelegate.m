//
//  AppDelegate.m
//  T动衫魂
//
//  Created by asus on 16/5/15.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "AppDelegate.h"
#import "FDBaseTabBarController.h"
#import "FDBaseNavigationController.h"
#import "FDHomeViewController.h"
#import "FDDiscoverViewController.h"
#import "FDSettingViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    FDHomeViewController *home = [[FDHomeViewController alloc] init];
    FDBaseNavigationController *navhome = [[FDBaseNavigationController alloc] initWithRootViewController:home];
    navhome.navigationBar.translucent = NO; //不透明
    navhome.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"icon_home_nor"] selectedImage:[UIImage imageNamed:@"icon_home_pre"]];
    
    FDDiscoverViewController *discover = [[FDDiscoverViewController alloc] init];
    FDBaseNavigationController *navDiscover = [[FDBaseNavigationController alloc] initWithRootViewController:discover];
    navDiscover.navigationBar.translucent = NO; //不透明
    navDiscover.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"买家秀" image:[UIImage imageNamed:@"icon_find_nor"] selectedImage:[UIImage imageNamed:@"icon_find_pre"]];
    
    FDSettingViewController *setting = [[FDSettingViewController alloc] init];
    FDBaseNavigationController *navSetting = [[FDBaseNavigationController alloc] initWithRootViewController:setting];
    navSetting.navigationBar.translucent = NO; //不透明
    navSetting.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"icon_setting_nor"] selectedImage:[UIImage imageNamed:@"icon_setting_pre"]];

    
    FDBaseTabBarController *tabBar = [[FDBaseTabBarController alloc] init];
    tabBar.tabBar.translucent = NO;//不透明
    
    [tabBar addChildViewController:navhome];
    [tabBar addChildViewController:navDiscover];
    [tabBar addChildViewController:navSetting];
    
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
    
    
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
