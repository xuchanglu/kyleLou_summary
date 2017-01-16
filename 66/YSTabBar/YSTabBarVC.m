//
//  MainVC.m
//  rwd
//
//  Created by 易健军 on 15/5/24.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "YSTabBarVC.h"

#import "AccountViewController.h"

#import "YSProjectListVC.h"

#import "YSNavVC.h"

#import "YSTabBar.h"

#import "YSHomePageVC.h"

@interface YSTabBarVC (){
    BOOL _firstEnter;
    BOOL _selectIndexChanged;
    
    YSTabBar *_customTabBar;
}

@end

@implementation YSTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self setupViewControllers];
    
    _firstEnter = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupViewControllers];
    
    [self setupTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UINavigationController *)navigationControllerWithRootVC:(UIViewController *)rootVC{
    YSNavVC *navVC = [[YSNavVC alloc] initWithRootViewController:rootVC];
    navVC.navigationBar.translucent = NO;
    
    [navVC setShowOp:^(BOOL bShow) {
        if(bShow == [_customTabBar isHidden]){
            [_customTabBar setHidden:!bShow];
        }
        
        self.tabBar.hidden = YES;
        [self.tabBar removeFromSuperview];
    }];
    
    return navVC;
}

- (void)setShowTabBar:(BOOL)showTabBar{
    _showTabBar = showTabBar;
    
    if(_showTabBar == [_customTabBar isHidden]){
        [_customTabBar setHidden:!_showTabBar];
    }
    
    self.tabBar.hidden = YES;
    [self.tabBar removeFromSuperview];
}

- (void)setupViewControllers{
    [UIViewController setupNavigationBar];
    
    self.tabBar.height = 0;
    self.tabBar.hidden = YES;
    [self.tabBar removeFromSuperview]; /// 关键
    
    self.tabBar.translucent = NO;

    NSString *title = nil;
    
    YSProjectListVC *investVC = [[YSProjectListVC alloc] init];
    title = @"我要投资";
    investVC.title = title;
    UINavigationController *navVC1 = [self navigationControllerWithRootVC:investVC];
    
    YSHomePageVC *mainVC = [[YSHomePageVC alloc] init];
    title = @"首页";
    UINavigationController *navVC3 = [self navigationControllerWithRootVC:mainVC];
    
    AccountViewController *userCenterVC = [[AccountViewController alloc] init];
    title = @"个人中心";
    userCenterVC.title = title;
    UINavigationController *navVC4 = [self navigationControllerWithRootVC:userCenterVC];
    
    
    [self loadState];
    self.viewControllers = @[navVC1,navVC3,navVC4];
}

- (void)setupTabBar{
    _customTabBar = [YSTabBar tabBar];
    _customTabBar.bottom = self.screenHeight;// - 64.0f;
    
    __weak __typeof(self) weakSelf = self;
    [_customTabBar setDidSelectIndex:^(NSUInteger idx) {
        [weakSelf setSelectedIndex:idx];
    }];
    [self.view addSubview:_customTabBar];
    
    self.selectedIndex = 1;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    
    [_customTabBar selectIndex:selectedIndex];
    
    if(!_firstEnter){
        _selectIndexChanged = YES;
    }
    
    if(_firstEnter){
        _firstEnter = NO;
    }
}

/** 检测用户是否投资和借款
 
 只做了借款的用户，点击进入切换到借款主页；
 只做了投资的用户，点击进入切换到投资主页；
 既做了投资也做了借款的点击进入切换到投资界面；
 即没做投资也没做借款的点击进入切换到投资界面；
 我们只做进入页面上的区分，不需要做到说投资用户就只能看到投资相关的界面。
 **/
- (void)loadState{
    if(_selectIndexChanged){
        return;
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillLayoutSubviews{
    
}

- (void)viewDidLayoutSubviews{
    
}

- (UITabBar *)tabBar{
    [super.tabBar removeFromSuperview];
    return nil;
}

@end
