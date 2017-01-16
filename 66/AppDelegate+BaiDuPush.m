//
//  AppDelegate+BaiDuPush.m
//  Text_GS
//
//  Created by tanyin on 16/6/22.
//  Copyright © 2016年 YBTC. All rights reserved.
//

#import "AppDelegate+BaiDuPush.h"
#import "BPush.h"
#import "LoginViewController.h"

static BOOL isBackGroundActivateApplication;
@implementation AppDelegate (BaiDuPush)

// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"test:%@",deviceToken);
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        // 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败
        // 网络错误
        if (error) {
            return ;
        }
        if (result) {
            // 确认绑定成功
            if ([result[@"error_code"]intValue]!=0) {
                return;
            }
            // 获取 channel_id
            NSString *myChannel_id = [BPush getChannelId];
            [USER_DEFAULT setObject:myChannel_id forKey:@"decode"];
            [USER_DEFAULT synchronize];
            
            [BPush listTagsWithCompleteHandler:^(id result, NSError *error) {
                if (result) {
                    NSLog(@"result ============== %@",result);
                }
            }];
            [BPush setTag:@"Mytag" withCompleteHandler:^(id result, NSError *error) {
                if (result) {
                    NSLog(@"设置tag成功");
                }
            }];
        }
    }];
}

// 当 DeviceToken 获取失败时，系统会回调此方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
}

// 此方法是 用户点击了通知，应用在前台 或者开启后台并且应用在后台 时调起
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    /**
     *  "{"id":"777","number":"3","start_lonlat":"29.7762790000,106.8812160000","start_addr":"\u6c99\u576a\u575d","end_addr":"\u89c2\u97f3\u6865","yytime":"2015-12-12 00:00:00","saymore":"\u5e26\u8d27","chartered_bus":"1","type":2}"
     */
    
    NSLog(@"收到推送通知： %@",userInfo);
    
    NSString *str =  userInfo[@"aps"][@"alert"];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    if ([json[@"type"] integerValue] == 1) {
        NSLog(@"付款通知-- %@ --",json);
    }
    if ([json[@"type"] integerValue] == 2) {
        NSLog(@"id ====== %@",json[@"id"]);
           [[NSNotificationCenter defaultCenter] postNotificationName:@"PushOrderInfo" object:nil userInfo:json];
    }
    if ([json[@"type"] integerValue] == 3) {
        NSLog(@"付款通知 -- %@ --",json);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Pay_MoneyInfo" object:nil userInfo:json];
    }
    if ([json[@"type"] integerValue] == 4) {
        NSLog(@"付款通知-- %@ --",json);
    }
    if ([json[@"type"] integerValue] == 5) {
        NSLog(@"付款通知-- %@ --",json);
        [[[UIAlertView alloc] initWithTitle:@"您的账号被另一台设备登录" message:@"请点击确定" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
    }
    completionHandler(UIBackgroundFetchResultNewData);
      if (application.applicationState == UIApplicationStateActive) {
    }
    //杀死状态下，直接跳转到跳转页面。
    if (application.applicationState == UIApplicationStateInactive && !isBackGroundActivateApplication)
    {
        NSLog(@"applacation is unactive ===== %@",userInfo);
        /*
         // 根视图是普通的viewctr 用present跳转
         [_tabBarCtr.selectedViewController presentViewController:skipCtr animated:YES completion:nil]; */
    }
    // 应用在后台。当后台设置aps字段里的 content-available 值为 1 并开启远程通知激活应用的选项
    if (application.applicationState == UIApplicationStateBackground) {
        NSLog(@"background is Activated Application ");
        // 此处可以选择激活应用提前下载邮件图片等内容。
        isBackGroundActivateApplication = YES;
    }
       NSLog(@"%@",userInfo);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        LoginViewController *roootVC = [[LoginViewController alloc]init];
        UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:roootVC];
        self.window.rootViewController = nav;
    }
}

@end
