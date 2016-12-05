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
    
    [self notificationAction];
    
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
        content.subtitle = @"2016年12月05日15:24:19  2016-12-05 15:24:24";
        content.body = @"iOS 10 中以前杂乱的和通知相关的 API 都被统一了，现在开发者可以使用独立的 UserNotifications.framework 来集中管理和使用 iOS 系统中通知的功能。在此基础上，Apple 还增加了撤回单条通知，更新已展示通知，中途修改通知内容，在通知中展示图片视频，自定义通知 UI 等一系列新功能，非常强大。";
        //content.badge = @10;
        content.sound = [UNNotificationSound defaultSound];
        
        content.categoryIdentifier = @"ZD_Category";
        
        UNNotificationAttachment *attachment = ({
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"hami" ofType:@"gif"];
            NSError * __autoreleasing *error = nil;
            UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"attachment" URL:[NSURL fileURLWithPath:imagePath] options:nil error:error];
            attachment;
        });
        content.attachments = @[attachment];
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
    // 5秒后通知(从你创建的时候开始计算)
    UNTimeIntervalNotificationTrigger *triger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    return triger;
}

//日期触发
- (UNNotificationTrigger *)canlendarTriger {
    NSDateComponents *component = ({
        NSDateComponents *component = [[NSDateComponents alloc] init];
        component.weekday = 2; //周一
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

- (void)notificationAction {
    //
    UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"action1" title:@"需要解锁" options:UNNotificationActionOptionAuthenticationRequired];
    UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"action2" title:@"启动app到前台显示" options:UNNotificationActionOptionForeground];
    UNNotificationCategory *category1 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1, action2] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    //
    UNNotificationAction *action3 = [UNNotificationAction actionWithIdentifier:@"action3" title:@"红色高亮" options:UNNotificationActionOptionDestructive];
    UNNotificationAction *action4 = [UNNotificationAction actionWithIdentifier:@"action4" title:@"启动app到前台显示" options:UNNotificationActionOptionAuthenticationRequired];
    UNNotificationCategory *category2 = [UNNotificationCategory categoryWithIdentifier:@"category2" actions:@[action3, action4] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    // TextInput
    UNTextInputNotificationAction *action5 = [UNTextInputNotificationAction actionWithIdentifier:@"action5" title:@"到前台来显示" options:UNNotificationActionOptionForeground textInputButtonTitle:@"回复" textInputPlaceholder:@"发表你的神评论~~~"];
    UNNotificationCategory *category3 = [UNNotificationCategory categoryWithIdentifier:@"category3" actions:@[action5] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    // 添加category
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithArray:@[category1, category2, category3]]];
}





@end



