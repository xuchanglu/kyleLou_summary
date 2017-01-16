//
//  MainVC.h
//  rwd
//
//  Created by 易健军 on 15/5/24.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSTabBarVC : UITabBarController


@property (nonatomic,assign) BOOL showTabBar;

/// 加载数据
- (void)loadState;


@end
