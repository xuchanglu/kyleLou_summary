//
//  AppDelegate.h
//  66
//
//  Created by Yasin-iOSer on 17/1/4.
//  Copyright © 2017年 Yasin-iOSer. All rights reserved.
//
#define kIsNotFirstIntoApp @"IsNotFirstIntoAppKey" //是否首次进入App的标志
#import <UIKit/UIKit.h>
#import "BBLaunchAdMonitor.h"
#import "YSTabBarVC.h"
#import "YSNavVC.h"
#import "LaunchVC.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) YSNavVC *navigationController;


@end

