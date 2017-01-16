//
//  YSTabBar.m
//  rwd
//
//  Created by Yasin-iOSer on 15/9/7.
//  Copyright (c) 2015年 yasin. All rights reserved.
//
/// Orange
#define YSOrangeColor RGB(221,107,30)//RGB(216,98,26)
/// green
#define YSGreenColor RGB(84,184,199)

///// 导航颜色
#define NavigationBarBgColor RGB(60,41,101)
/// 标题颜色
#define NavigationTitleDefualtColor [UIColor whiteColor]

///常用红色
#define YSCommRedColor RGB(233,84,97)
///视图背景色
#define YSViewBgColor RGB(239,239,244)
///金额绿色 (减少)
#define YSAmountReduceColor RGB(23,159,17)

///正常 蓝
#define YSMoveLockNormalColor RGB(30,172,252)
///错误 红
#define YSMoveLockErrorColor RGB(252,54,30)

/// cyan
#define YSCYanColor RGB(103,195,208)

/// cicel text color
#define YSCircleTextColor RGB(161,209,224)

/// progress text color
#define YSProgressTextColor RGB(99,195,208)

#define YJJHTTPLoggerEnabled

///分页功能
#define PageIndexStart 0 /// index起始
#define PageSizeDefault 10 /// 默认分页

#import "UIView+ViewExtral.h"

#import "UIColor+Colours.h"

#import "UIScreen+ScreenExtral.h"

#import "UILabel+ContentSize.h"

#import "UIButton+Bootstrap.h"

#import "UIView+FrameExtral.h"

#import "YSTabBar.h"

#import "YSTabBarItem.h"

@interface YSTabBar (){
    YSTabBarItem *_homePageItem;
}

@end

@implementation YSTabBar

static NSInteger YSTabBarItemTagBase = 1000000;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)tabBar{
    YSTabBar *tabBar = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    tabBar.width = self.screenWidth;
    [tabBar setupItems];
    return tabBar;
}

- (void)setupItems{
    _contentView.autoresizesSubviews = NO;
    
    CGFloat sWidth = self.screenWidth;
    NSInteger countPerLine = 3;
    CGFloat itemWidth = sWidth/countPerLine;
    
    UIColor *titleColor = [UIColor grayColor];
    UIColor *titleSelectedColor = YSOrangeColor;
    
    YSTabBarItem *item0 = [YSTabBarItem itemWithIconImage:[UIImage imageNamed:@"tabico_bid"] selectedImage:[UIImage imageNamed:@"tabico_bid_a"] title:@"我要投资" titleColor:titleColor titleSelectedColor:titleSelectedColor];
    item0.tag = YSTabBarItemTagBase + 0;
    item0.left = (itemWidth - item0.width) * .7;
    [item0 addTapWithTarget:self selector:@selector(tapGestureAction:)];
    [_contentView addSubview:item0];
    
//    YSTabBarItem *item1 = [YSTabBarItem itemWithIconImage:[UIImage imageNamed:@"tabico_invest"] selectedImage:[UIImage imageNamed:@"tabico_invest_a"] title:@"我要借款" titleColor:titleColor titleSelectedColor:titleSelectedColor];
//    item1.tag = YSTabBarItemTagBase + 1;
//    item1.left = itemWidth * 1.5 - item1.width * .5;
//    [item1 addTapWithTarget:self selector:@selector(tapGestureAction:)];
//    [_contentView addSubview:item1];
    
    YSTabBarItem *item2 = [YSTabBarItem itemWithIconImage:[UIImage imageNamed:@"tabico_logo"] selectedImage:[UIImage imageNamed:@"tabico_logo_a"] title:@"首页" titleColor:titleColor titleSelectedColor:titleSelectedColor bigItem:YES];
    item2.tag = YSTabBarItemTagBase + 1;
    item2.left = (sWidth - item2.width) * .5;
    item2.bottom = self.height;
    [item2 addTapWithTarget:self selector:@selector(tapGestureAction:)];
    [self addSubview:item2];
    _homePageItem = item2;
    
    YSTabBarItem *item3 = [YSTabBarItem itemWithIconImage:[UIImage imageNamed:@"tabico_user"] selectedImage:[UIImage imageNamed:@"tabico_user_a1"] title:@"个人中心" titleColor:titleColor titleSelectedColor:titleSelectedColor];
    item3.tag = YSTabBarItemTagBase + 2;
    item3.left = sWidth - item0.left - item3.width;
    [item3 addTapWithTarget:self selector:@selector(tapGestureAction:)];
    [_contentView addSubview:item3];
    
//    YSTabBarItem *item4 = [YSTabBarItem itemWithIconImage:[UIImage imageNamed:@"tabico_more"] selectedImage:[UIImage imageNamed:@"tabico_more_a"] title:@"更多" titleColor:titleColor titleSelectedColor:titleSelectedColor];
//    item4.tag = YSTabBarItemTagBase + 4;
//    item4.left = itemWidth * 4.5 - item4.width * .5;
//    [item4 addTapWithTarget:self selector:@selector(tapGestureAction:)];
//    [_contentView addSubview:item4];
    
    [item0 setSelected:YES];
    _selectedIndex = 0;
}

#pragma mark - --- UITapGesture
- (void)tapGestureAction:(UITapGestureRecognizer *)tap{
    NSInteger tag = tap.view.tag;
    NSUInteger idxOfItem = tag - YSTabBarItemTagBase;
    
    [self selectIndex:idxOfItem];
        if(_didSelectIndex){
            _didSelectIndex(idxOfItem);
        }
}

- (void)selectIndex:(NSUInteger)idx{
    if(_selectedIndex == idx){
        return;
    }

    [[self itemWithIdx:idx] setSelected:YES];
    [[self itemWithIdx:_selectedIndex] setSelected:NO];
    _selectedIndex = idx;
}

- (YSTabBarItem *)itemWithIdx:(NSUInteger)idx{
    YSTabBarItem *item = nil;
    NSInteger tag = idx + YSTabBarItemTagBase;
    if(1 == idx){
        item = (YSTabBarItem *)[self viewWithTag:tag];
    }else{
        item = (YSTabBarItem *)[_contentView viewWithTag:tag];
    }
    return item;
}

#pragma mark - --- Touchs action
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    /// 排出首页及其他item的选择区域
    if(CGRectContainsPoint(_homePageItem.frame, point)|| CGRectContainsPoint(self.contentView.frame, point)){
        return YES;
    }else{
        /// 过滤掉,下一个响应
        return NO;
    }
}



@end
