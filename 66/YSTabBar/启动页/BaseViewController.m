//
//  BaseViewController.m
//  66
//
//  Created by Yasin-iOSer on 17/1/10.
//  Copyright © 2017年 Yasin-iOSer. All rights reserved.
//

#import "BaseViewController.h"
#import "YSTabBarVC.h"
#import "LoginViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.baseView];
    [self.view sendSubviewToBack:self.baseView];
    if (IOSVersion >= 7.0f) {
        UIView* tempstartview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
        self.stateView = tempstartview;
        [self.view addSubview:tempstartview];
        
        self.baseView.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
    }else{
        self.baseView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }

    _sWidth = self.screenWidth;
    _sHeight = self.screenHeight;
    if(!self.view.constraints || ![self.view.constraints count]){
        self.view.size = [UIScreen screenSize];
    }
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationSlide;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBarHidden = NO;
    
    if(self.tabBarController && [self.tabBarController isKindOfClass:[YSTabBarVC class]]){
        YSTabBarVC *tabBarVC = (YSTabBarVC *)self.tabBarController;
        tabBarVC.showTabBar = (1 == [self.navigationController.viewControllers count]);
    }
}

#pragma mark - --- Goto VC
- (void)gotoLoginVC {
    [self navigationPushViewController:[LoginViewController class]];
}

- (void)gotoMainVC {
    [[[UIApplication sharedApplication] delegate] window].rootViewController = [YSTabBarVC new];
}

- (void)showActionSheet:(id)sender
{
    //1、创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    if (imageArray) {
        [shareParams SSDKSetupShareParamsByText:@"最近要加微信朋友圈分享的功能，上官网下文件，照着文档搭环境，但是总有错误，于是百度博客来看，发现和官方文档一样，解决不了自己的问题，现在问题解决了，分享出来希望对大家有帮助。"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://www.mob.com"]
                                          title:@"我的论坛"
                                           type:SSDKContentTypeAuto];
    }
    //2、分享
    [ShareSDK showShareActionSheet:sender
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   switch (state)
                   {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@", error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
               }];
}

/// call customer phone - 拨打客户电话
+ (void)callCustomerPhone{
    [self callPhone:@"13526430124" valid:NO completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
