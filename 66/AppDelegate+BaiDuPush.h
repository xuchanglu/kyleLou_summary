//
//  AppDelegate+BaiDuPush.h
//  Text_GS
//
//  Created by tanyin on 16/6/22.
//  Copyright © 2016年 YBTC. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (BaiDuPush) <UIAlertViewDelegate>

@property (copy, nonatomic) void (^BaiDuPushcomplete)();

@end
