//
//  LLTextFeild.m
//  rwd
//
//  Created by lyc on 15/3/25.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "YSTextFeild.h"

#define NSLogCMD NSLog(@"%@",NSStringFromSelector(_cmd));

@interface YSTextFeild (){
    NSString *_commitTxt;
    void (^_completion)(NSString *inputTxt);
}

@end

@implementation YSTextFeild

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.inputAccessoryView = [self getAcceseryView];
    }
    return self;
}

- (CGRect)fixedRectForBounds:(CGRect)bounds{
    CGRect fixedBounds = CGRectInset(bounds, 5, 0);
    if(self.leftView){
        fixedBounds.size.width -= self.leftView.bounds.size.width;
    }
    return fixedBounds;
}

- (CGRect)textRectForBounds:(CGRect)bounds{
//    NSLogCMD
    return [self fixedRectForBounds:bounds];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
//    NSLogCMD
    return [self fixedRectForBounds:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
//    NSLogCMD
    return [self fixedRectForBounds:bounds];
}


- (void)setIsSelectType:(BOOL)isSelectType{
    _isSelectType = isSelectType;
    if(_isSelectType){
        self.rightViewMode = UITextFieldViewModeAlways;
        UIImageView *downArrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"info_arrow_down"]];
        downArrowImgView.size = CGSizeMake(9, 5);
        self.rightView = downArrowImgView;
    }else{
        self.rightViewMode = UITextFieldViewModeNever;
        self.rightView = nil;
    }
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

- (void)setCommitText:(NSString *)commitTxt completion:(void (^)(NSString *inputTxt))completion{
    UIView *accView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
    accView.backgroundColor = [UIColor colorWithRed:217/225.0f green:220/225.0f blue:227/225.0f alpha:1.0];
    
    
    
    UIButton *endBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 0, 48, 38)];
    [endBtn setImage:[UIImage imageNamed:@"Keyboard_Hide_Normal"] forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(btnEndEditingAction:) forControlEvents:UIControlEventTouchUpInside];
    [accView addSubview:endBtn];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 56, 2, 48, 34)];
    [btn addTarget:self action:@selector(btnCommitAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = NavigationBarBgColor;
    [btn setTitle:commitTxt forState:UIControlStateNormal];
    [btn setCornerRadius:3.0f];
    
    [accView addSubview:btn];
    
    _commitBtn = btn;
    _completion = completion;
    self.inputAccessoryView = accView;
}

/// 添加右视图
- (void)setRightViewWithTips:(NSString *)tips{
    if(!tips || ![tips length]){
        return;
    }
    
    self.rightViewMode = UITextFieldViewModeAlways;
    
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 21, self.height)];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.textColor = [UIColor grayColor];
    tipsLabel.backgroundColor = [UIColor clearColor];
    tipsLabel.text = tips;
    tipsLabel.font = [UIFont systemFontOfSize:14.0f];
    
    self.rightView = tipsLabel;
}

/// 添加右视图
- (void)setRightImageView{
    self.rightViewMode = UITextFieldViewModeAlways;
    
    UIImage *arrowImage = [UIImage imageNamed:@"loan_dropdown"];
    CGSize imageSize = arrowImage.size;
    CGFloat scale = self.height/imageSize.height;
    
    UIImageView *downArrowImgView = [[UIImageView alloc] initWithImage:arrowImage];
    downArrowImgView.size = CGSizeMake(scale * imageSize.width, self.height);
    
    self.rightView = downArrowImgView;
}

#pragma mark - --- Button Action

- (void)btnEndEditingAction:(UIButton *)sender{
    [self endEditing:YES];
}

- (void)btnCommitAction:(UIButton *)sender{
    if(_completion){
        _completion(self.text);
    }
}

@end
