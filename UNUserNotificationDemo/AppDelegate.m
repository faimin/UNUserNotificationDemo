//
//  AppDelegate.m
//  UNUserNotificationDemo
//
//  Created by 符现超 on 2016/12/3.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//
// https://onevcat.com/2016/08/notification/
// https://github.com/liuyanhongwl/ios_common/blob/master/files/ios10_usernotification.md#%E8%8E%B7%E5%8F%96%E6%9D%83%E9%99%90

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //MARK: 注册通知
    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    // 这几种注册类型在手机的setting中单个设置
    UNAuthorizationOptions authorization = UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionCarPlay;
    // 获取权限
    [notificationCenter requestAuthorizationWithOptions:authorization completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // token registration（需要与APNs建立连接）
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
    }];
    
    // 获取用户授权相关信息
    [notificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        NSLog(@"UNNotificationSettings ==> %@", settings);
    }];
    
    return YES;
}

#pragma mark - UNUserNotificationCenterDelegate
// 13分钟
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"将要弹出通知");
    NSDictionary *userInfo = notification.request.content.userInfo;
}

// 本地、远程通知点击都会进入这个方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSLog(@"收到推送通知");
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    completionHandler();
}

#pragma mark -

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
