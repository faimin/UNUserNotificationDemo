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

static NSString * const TimeIntervalId = @"TimeIntervalId";
static NSString * const CalendarId = @"CalendarId";
static NSString * const LocalRegionId = @"LocalRegionId";

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

#pragma mark - LocalNotification

- (void)contentNotification {
    UNMutableNotificationContent *content = ({
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"第一条推送标题";
        content.subtitle = @"推送副标题";
        content.body = @"详细内容xxxxxxxxxxx";
        content.badge = @1;
        content.sound = [UNNotificationSound defaultSound];
        content;
    });
    
    UNNotificationTrigger *triger = nil;
    NSString *importantRequestIdentifier = @""; // 此参数不能为nil
    switch (self.trigerType) {
        case TrigerType_TimeInternal:
            triger = [self timeIntervalTriger];
            importantRequestIdentifier = TimeIntervalId;
            break;
        case TrigerType_Calendar:
            triger = [self canlendarTriger];
            importantRequestIdentifier = CalendarId;
            break;
        case TrigerType_Location:
            triger = [self locationNotification];
            importantRequestIdentifier = LocalRegionId;
            break;
        default:
            break;
    }
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:importantRequestIdentifier content:content trigger:triger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

#pragma mark - Triger

// 定时器触发
- (UNNotificationTrigger *)timeIntervalTriger {
    // 每5m通知一次(从你创建的时候开始计算)
    UNTimeIntervalNotificationTrigger *triger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:YES];
    return triger;
}

//日期触发
- (UNNotificationTrigger *)canlendarTriger {
    NSDateComponents *component = ({
        NSDateComponents *component = [[NSDateComponents alloc] init];
        component.weekday = 2;
        component.hour = 17;
        component.minute = 30;
        component;
    });
    UNCalendarNotificationTrigger *triger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:component repeats:NO];
    return triger;
}

//位置触发
- (UNNotificationTrigger *)locationNotification {
    CLRegion *region = ({
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(100, 100);
        CLRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:100 identifier:@"center"];
        region.notifyOnEntry = YES;
        region.notifyOnExit = YES;
        region;
    });
    UNLocationNotificationTrigger *triger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:NO];
    return triger;
}

#pragma mark - Notification Management
// Unschedules the specified notification requests
// 此方法是异步执行的
- (void)unScheduleNotification {
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[]];
}

- (void)updateNotification {
    // 重新设置request中的triger或者content，然后再添加到当前通知中心
}

// Removes the specified notifications from Notification Center.
// 此方法也是异步操作的，在后台线程执行
- (void)removeNotification {
    [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[]];
}

#pragma mark - Notification Action

- (void)action {
    UNNotificationAction *action = [UNNotificationAction actionWithIdentifier:@"notificationAction" title:@"ActionTitle" options:UNNotificationActionOptionAuthenticationRequired | UNNotificationActionOptionDestructive];
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"category" actions:@[action] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithArray:@[category]]];
    
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
