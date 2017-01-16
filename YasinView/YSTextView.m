//
//  YSTextView.m
//  rwd
//
//  Created by YiJianJun on 15/11/10.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "YSTextView.h"

@implementation YSTextView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.inputAccessoryView = [self getAcceseryView];
    }
    return self;
}

- (UIView *)getAcceseryView{
    UIView *accView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
    accView.backgroundColor = [UIColor colorWithRed:217/225.0f green:220/225.0f blue:227/225.0f alpha:1.0];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 56, 0, 48, 38)];
    [btn setImage:[UIImage imageNamed:@"Keyboard_Hide_Normal"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnEndEditingAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [accView addSubview:btn];
    
    return accView;
}

#pragma mark - --- Button Action

- (void)btnEndEditingAction:(UIButton *)sender{
    [self endEditing:YES];
}

@end
