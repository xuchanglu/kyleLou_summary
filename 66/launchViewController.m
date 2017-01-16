//
//  launchViewController.m
//  登录注册
//
//  Created by Yasin-iOSer on 16/12/2.
//  Copyright © 2016年 Yasin-iOSer. All rights reserved.
//

#define kIsNotFirstIntoApp @"IsNotFirstIntoAppKey" //是否首次进入App的标志

#import "launchViewController.h"

@interface launchViewController ()

@end

@implementation launchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)wancehng:(id)sender {
    [USER_DEFAULT setBool:YES forKey:kIsNotFirstIntoApp];
    [USER_DEFAULT synchronize];
    [self gotoMainVC];
}

@end
