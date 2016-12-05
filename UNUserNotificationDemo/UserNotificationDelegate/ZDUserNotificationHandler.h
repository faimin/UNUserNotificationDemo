//
//  ZDUserNotificationHandler.h
//  UNUserNotificationDemo
//
//  Created by 符现超 on 2016/12/5.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZDUserNotificationHandler : NSObject

+ (instancetype)shareInstance;

- (void)registerNotification;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

@end
