//
//  ViewController.m
//  UNUserNotificationDemo
//
//  Created by 符现超 on 2016/12/3.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import "ViewController.h"
#import "LocalNotificationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSInteger row = indexPath.row;
//    LocalNotificationController *localVC = ({
//        LocalNotificationController *localVC = [LocalNotificationController new];
//        localVC.trigerType = row == 0 ? TrigerType_TimeInternal : TrigerType_Calendar;
//        localVC;
//    });
//    [self.navigationController showViewController:localVC sender:self];
//}

@end
