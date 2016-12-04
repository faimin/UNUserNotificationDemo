//
//  LocalNotificationController.m
//  UNUserNotificationDemo
//
//  Created by 符现超 on 2016/12/3.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import "LocalNotificationController.h"
@import UserNotifications;
@import CoreLocation;

@interface LocalNotificationController ()

@end

@implementation LocalNotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self contentNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)contentNotification {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"第一条推送标题";
    content.subtitle = @"推送副标题";
    content.body = @"详细内容";
    content.badge = @1;
}

// 定时器通知
- (void)timeIntervalNotification {
    // 每2分钟通知一次(从你创建的时候开始计算)
    UNTimeIntervalNotificationTrigger *triger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:120 repeats:YES];
    
}

//日历定时通知
- (void)canlendarNotification {
    NSDateComponents *component = [[NSDateComponents alloc] init];
    UNCalendarNotificationTrigger *triger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:component repeats:NO];
}

- (void)regionNotification {
    CLRegion *region = [[CLRegion alloc] init];
    UNLocationNotificationTrigger *triger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
