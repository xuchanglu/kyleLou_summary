//
//  YSProjectListVC.m
//  66
//
//  Created by Yasin-iOSer on 17/1/10.
//  Copyright © 2017年 Yasin-iOSer. All rights reserved.
//

#import "YSProjectListVC.h"
#import "SViewController.h"
#import "YSHelpCenterDetailVC.h"

@interface YSProjectListVC ()

@end

@implementation YSProjectListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor yellowColor];
    UIButton * btn = [UIButton buttonWithFrame:CGRectMake(100, 100, 50, 50) btnTag:10 target:self action:@selector(qwe)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    UIButton * btqn = [UIButton buttonWithFrame:CGRectMake(100, 300, 50, 50) btnTag:10 target:self action:@selector(qw1e)];
    btqn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btqn];
    
    UIButton * btqn3 = [UIButton buttonWithFrame:CGRectMake(100, 400, 50, 50) btnTag:10 target:self action:@selector(qw1sde)];
    btqn3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btqn3];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
}

- (void)qwe {
    [self.navigationController pushViewController:[SViewController new]  animated:YES];
}
- (void)qw1e {
    [self.navigationController pushViewController:[YSHelpCenterDetailVC new]  animated:YES];
}
- (void)qw1sde {
    [self showActionSheet:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

