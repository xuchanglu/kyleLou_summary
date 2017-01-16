//
//  SViewController.m
//  66
//
//  Created by Yasin-iOSer on 17/1/6.
//  Copyright © 2017年 Yasin-iOSer. All rights reserved.
//

#import "SViewController.h"

#import <RongIMKit/RongIMKit.h>
#import "RCDCustomerServiceViewController.h"
@interface SViewController ()

@end

@implementation SViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    RCDCustomerServiceViewController *chatService = [[RCDCustomerServiceViewController alloc] init];
#define SERVICE_ID @"KEFU148040312019879"
    chatService.userName = @"客服";
    chatService.conversationType = ConversationType_CUSTOMERSERVICE;
    chatService.targetId = SERVICE_ID;
    chatService.title = chatService.userName;
    // startCustomerServiceChat  chatService.csInfo = csInfo; //用户的详细信息，此数据用于上传用户信息到客服后台，数据的nickName和portraitUrl必须填写。(目前该字段暂时没用到，客服后台显示的用户信息是你获取token时传的参数，之后会用到）
    [self.navigationController pushViewController :chatService animated:YES];
}


@end

