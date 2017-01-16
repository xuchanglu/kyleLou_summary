//
//  YSTabBar.h
//  rwd
//
//  Created by Yasin-iOSer on 15/9/7.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSTabBar : UIView{
    NSUInteger _selectedIndex;
}

@property (nonatomic,weak) IBOutlet UIView *contentView;

@property (nonatomic,copy) void (^didSelectIndex)(NSUInteger idxOfItem);

+ (instancetype)tabBar;

- (void)setupItems;

- (void)selectIndex:(NSUInteger)idx;

@end
