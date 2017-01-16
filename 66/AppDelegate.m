//
//  AppDelegate.m
//  66
//
//  Created by Yasin-iOSer on 17/1/4.
//  Copyright © 2017年 Yasin-iOSer. All rights reserved.
//
#import <RongIMKit/RongIMKit.h>
#import "AppDelegate.h"
#import "AppDelegate+ShareSDK.h"
#import "AppDelegate+BaiDuPush.h"
#import "BPush.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
static BOOL isBackGroundActivateApplication;
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AppDelegate ()
{
    UIViewController *launchViewController;
    UIViewController *secondLaunchController;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    /// 通用配置
    __weak UINavigationSetting *navSetting = [UINavigationSetting sharedNavigationSetting];
    /// 导航颜色
    navSetting.barBgColor = NavigationBarBgColor;
    /// 标题颜色
    navSetting.titleDefaultColor = NavigationTitleDefualtColor;
    [UIViewController setLeftCustomerItemImage:[UIImage imageNamed:@"nav_backBtn_img"]];
    [UIViewController setupNavigationBar];

    [[RCIM sharedRCIM] initWithAppKey:@"z3v5yqkbzclj0"];
    [[RCIM sharedRCIM]  connectWithToken:@"FoGzODIYFu3YQgSpWNRdTkC4945laZgo6Vb1Rea6pTbu9wgdJ3zKbQP03ia06iV5v0BELgRqkks=" success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%zd", status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];

    ///启动动画 1.75s
    LaunchVC *launchVC = [[LaunchVC alloc] init];
    [launchVC setDidFinishLoad:^{
        [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        [self loadMainPage];
    }];
    
    YSNavVC *navVC = [[YSNavVC alloc] initWithRootViewController:launchVC];
    // 当translucent设置为YES时，导航栏呈现半透明效果，设置为no的时候则不是半透明的
    navVC.navigationBar.translucent = NO;
    self.window.rootViewController = navVC;
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 分享初始化
    [self initShareSDK];
    
    /**注册远程通知**/
    [self RegisterForRemoteNotificationapplication:application WithOptions:launchOptions];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)loadMainPage{
    BOOL bNotFirstIntoApp = [USER_DEFAULT boolForKey:kIsNotFirstIntoApp];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    launchViewController = [mainStory instantiateViewControllerWithIdentifier:@"launchViewController"];
    secondLaunchController = (UITabBarController *)[mainStory instantiateViewControllerWithIdentifier:@"secondLaunchController"];
    if (!bNotFirstIntoApp) {  //判断是否为首次进入APP
        _navigationController = [[YSNavVC alloc] initWithRootViewController:launchViewController];
    }else {
        _navigationController = [[YSNavVC alloc] initWithRootViewController:secondLaunchController];
    }
    _window.rootViewController = _navigationController;
    [self.window makeKeyAndVisible];

}

/**注册远程通知**/
- (void)RegisterForRemoteNotificationapplication:(UIApplication *)application WithOptions:(NSDictionary *)launchOptions {
    // iOS10 下需要使用新的 API
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  // Enable or disable features based on authorization.
                                  if (granted) {
                                      [application registerForRemoteNotifications];
                                  }
                              }];
#endif
    }
    else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
    
#warning 测试 开发环境 时需要修改BPushMode为BPushModeDevelopment 需要修改Apikey为自己的Apikey
    
    // 在 App 启动时注册百度云推送服务，需要提供 Apikey
    
    [BPush registerChannel:launchOptions apiKey:@"" pushMode:BPushModeDevelopment withFirstAction:@"打开" withSecondAction:@"关闭" withCategory:@"test" useBehaviorTextInput:YES isDebug:YES];

    // 禁用地理位置推送 需要再绑定接口前调用。
    
    [BPush disableLbs];
    
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        [BPush handleNotification:userInfo];
    }
#if TARGET_IPHONE_SIMULATOR
    Byte dt[32] = {0xc6, 0x1e, 0x5a, 0x13, 0x2d, 0x04, 0x83, 0x82, 0x12, 0x4c, 0x26, 0xcd, 0x0c, 0x16, 0xf6, 0x7c, 0x74, 0x78, 0xb3, 0x5f, 0x6b, 0x37, 0x0a, 0x42, 0x4f, 0xe7, 0x97, 0xdc, 0x9f, 0x3a, 0x54, 0x10};
    [self application:application didRegisterForRemoteNotificationsWithDeviceToken:[NSData dataWithBytes:dt length:32]];
#endif
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
