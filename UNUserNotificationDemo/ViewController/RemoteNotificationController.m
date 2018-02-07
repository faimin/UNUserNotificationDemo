//
//  RemoteNotificationController.m
//  UNUserNotificationDemo
//
//  Created by 符现超 on 2016/12/3.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import "RemoteNotificationController.h"

@interface RemoteNotificationController ()

@end

@implementation RemoteNotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 添加远程推送格式

- (void)addRemoteNotification
{
    //ios10新版文案多样推送
    /*
    {
        "aps":{
            "alert":{
                "title":"Testing.. (52)",
                "subtitle":"subtitle",
                "body":"body"
            },
            "badge":1,
            "sound":"default"
        }
    }
     */
}

- (void)addRemoteNotificationDownload
{
    //后台做一些操作增加字段："content-available":1
    /*
    {
        "aps":{
            "alert":"Testing.. (34)",
            "badge":1,
            "sound":"default",
            "content-available":1
        }
    }
     */
}

- (void)addRemoteNotificationSilentDownload
{
    //去掉alert、badge、sound字段实现静默推送，增加增加字段："content-available":1，也可以在后台做一些事情。
    /*
    {
        "aps":{
            "content-available":1
        }
    }
     */
}

- (void)addRemoteNotificationCategory
{
    //指定操作策略，需增加字段："category":"categoryId"
    /*
    {
        "aps":{
            "alert":"Testing.. (34)",
            "badge":1,
            "sound":"default",
            "category":"category1"
        }
    }
     */
}

#pragma mark - 远程-附件

- (void)addRemoteNotificationAttachment
{
    //为了给远程推送增加附件，使推送是可变的，需增加字段："mutable-content":1
    /*
    {
        "aps":{
            "alert":"Testing.. (34)",
            "badge":1,
            "sound":"default",
            "mutable-content":1
        }
    }
     */
}



@end
