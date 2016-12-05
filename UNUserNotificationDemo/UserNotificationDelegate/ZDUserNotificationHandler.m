//
//  ZDUserNotificationHandler.m
//  UNUserNotificationDemo
//
//  Created by 符现超 on 2016/12/5.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import "ZDUserNotificationHandler.h"
@import UserNotifications;

@interface ZDUserNotificationHandler ()<UNUserNotificationCenterDelegate>

@end

@implementation ZDUserNotificationHandler

#pragma mark - Singleton
static ZDUserNotificationHandler *notificationHandler = nil;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!notificationHandler) {
            notificationHandler = [[ZDUserNotificationHandler alloc] init];
        }
    });
    return notificationHandler;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (!notificationHandler) {
        notificationHandler = [super allocWithZone:zone];
    }
    return notificationHandler;
}

#pragma amrk - lifeCycle

- (instancetype)init {
    if (self = [super init]) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    return self;
}

#pragma mark - Methods
//MARK: 注册通知
- (void)registerNotification {
    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    // 这几种注册类型在手机的setting中单个设置
    UNAuthorizationOptions authorization = UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionCarPlay;
    // 获取权限
    [notificationCenter requestAuthorizationWithOptions:authorization completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // token registration（需要与APNs建立连接）
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            
            // 获取用户授权的相关信息
            [notificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                NSLog(@"UNNotificationSettings ==> %@", settings);
            }];
        } else {
            NSLog(@"不允许注册通知");
        }
    }];

}

#pragma mark - UNUserNotificationCenterDelegate
// 应用在前台显示的时候点击收到的通知后，调用此方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    __unused NSDictionary *userInfo = notification.request.content.userInfo;
    
    //  if you don't want in-app presentation, you just don't pass any parameters.
    UNNotificationPresentationOptions type = UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert;
    completionHandler(type);
}

// 本地、远程通知点击都会进入这个方法
// 应用被杀掉或者在后台时，点击通知后调用的方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    __unused NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    // 此标识可以用来判断用户是否是通过点击通知进入的app，是本地通知还是远程通知
    NSString *identifier = response.actionIdentifier;
    if ([identifier isEqualToString:UNNotificationDefaultActionIdentifier]) {
        NSLog(@"通过通知打开的app");
    }
    
    UNNotificationTrigger *triger = response.notification.request.trigger;
    if ([triger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"这个是远程通知");
    } else {
        NSLog(@"这个是本地通知, Triger: %@", NSStringFromClass([triger class]));
    }
    
    completionHandler();
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    NSLog(@"didReceiveRemoteNotification---application.state=%ld", application.applicationState);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

@end