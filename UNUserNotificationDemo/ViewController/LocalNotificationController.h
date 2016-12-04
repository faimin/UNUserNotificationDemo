//
//  LocalNotificationController.h
//  UNUserNotificationDemo
//
//  Created by 符现超 on 2016/12/3.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TrigerType) {
    TrigerType_TimeInternal,
    TrigerType_Calendar,
    TrigerType_Location
};

@interface LocalNotificationController : UIViewController

@property (nonatomic, assign) TrigerType trigerType;

@end
