//
//  YSHelpCenterSectionView.m
//  rwd
//
//  Created by Yasin-iOSer on 15/9/21.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "YSHelpCenterSectionView.h"

@interface YSHelpCenterSectionView (){
    UIView *_sBgView;
    UILabel *_sCircleLabel;
    UILabel *_sTitleLabel;
}

@end

@implementation YSHelpCenterSectionView

static CGFloat YSHelpCenterSectionViewTitleWidth = 0.0f;

+ (void)initialize{
    [self configTitleWidth];
}

+ (void)configTitleWidth{
    if(!YSHelpCenterSectionViewTitleWidth){
        YSHelpCenterSectionViewTitleWidth = self.screenWidth - 27;/// - 20 - 3 -4//bgWidth - circleRight - 4;
    }
}

- (NSUInteger)sectionTitleFontSize{
    if(!_sectionTitleFontSize){
        _sectionTitleFontSize = 16.0f;
    }
    return _sectionTitleFontSize;
}

- (CGFloat)topAndBottomMargin{
    if(_topAndBottomMargin){
        _topAndBottomMargin = 8.0f;
    }
    return _topAndBottomMargin;
}

- (void)configViews{
    if(_sBgView){
        return;
    }
    CGSize size = CGSizeMake(self.screenWidth, YSHelpCenterSectionViewDefaultHeight);
    [self configViewsWithSize:size];
}

- (void)configViewsWithSize:(CGSize)size{
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    
    CGRect bgFrame = frame;
    bgFrame.size.height -= 4;
    _sBgView = [[UIView alloc] initWithFrame:bgFrame];
    
    CGFloat bgHeight = bgFrame.size.height;
    
    CGFloat circleWH = 3;
    CGRect rect = CGRectZero;
    if(_vAutoCenter){
        rect = CGRectMake(20, .5 * (bgHeight - circleWH), circleWH, circleWH);
    }else{
        rect = CGRectMake(20, self.topAndBottomMargin + .5 * (self.sectionTitleFontSize - circleWH), circleWH, circleWH);
    }
    _sCircleLabel = [[UILabel alloc] initWithFrame:rect];
    [_sCircleLabel setRadiusSharp];
    [_sBgView addSubview:_sCircleLabel];
    
    CGFloat fontSize = self.sectionTitleFontSize;//16.0f;
    
    if(_vAutoCenter){
        rect = CGRectMake(_sCircleLabel.right + 4, .5 * (bgHeight - fontSize - 2), YSHelpCenterSectionViewTitleWidth, fontSize + 4);
    }else{
        rect = CGRectMake(_sCircleLabel.right + 4, self.topAndBottomMargin, YSHelpCenterSectionViewTitleWidth, fontSize + 4);
    }
    
    _sTitleLabel = [[UILabel alloc] initWithFrame:rect];
    _sTitleLabel.font = [UIFont systemFontOfSize:fontSize];
    _sTitleLabel.backgroundColor = [UIColor clearColor];
    _sTitleLabel.numberOfLines = 0;
    [_sBgView addSubview:_sTitleLabel];
    
    [self.contentView addSubview:_sBgView];
    
    [_sBgView addTapWithTarget:self selector:@selector(tapGestureAction:)];
    
    self.contentView.backgroundColor = [UIColor clearColor];
}

+ (CGFloat)sectionViewHeightForSectionTitle:(NSString *)title font:(UIFont *)font topAndBottomMargin:(CGFloat)topAndBottomMargin{
    [self configTitleWidth];
    CGSize titleSize = [title sizeForSelfWithFont:font limitWidth:YSHelpCenterSectionViewTitleWidth lineBreakMode:NSLineBreakByWordWrapping];
    titleSize.height += (4 + topAndBottomMargin * 2);// 上下间隔
    
    return fmaxf(titleSize.height , YSHelpCenterSectionViewDefaultHeight);
}

+ (CGFloat)sectionViewHeightForSectionTitle:(NSString *)title font:(UIFont *)font{
    return [self sectionViewHeightForSectionTitle:title font:font topAndBottomMargin:4.0f];
}

- (void)setSectionSelected:(BOOL)sectionSelected{
    _sectionSelected = sectionSelected;
    
    if(_sectionSelected){
        _sCircleLabel.backgroundColor = [UIColor whiteColor];
        _sTitleLabel.textColor = [UIColor whiteColor];
        _sBgView.backgroundColor = YSGreenColor;
    }else{
        _sCircleLabel.backgroundColor = YSGreenColor;
        _sTitleLabel.textColor = [UIColor darkGrayColor];
        _sBgView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setSectionTitle:(NSString *)sectionTitle{
    _sectionTitle = sectionTitle;
    
    _sTitleLabel.width = YSHelpCenterSectionViewTitleWidth;
    _sTitleLabel.text = sectionTitle;
    
    [_sTitleLabel sizeToFit];
    UIFont *font = [UIFont systemFontOfSize:self.sectionTitleFontSize];
    
    CGFloat height = [self.class sectionViewHeightForSectionTitle:sectionTitle font:font];
    CGFloat bgHeight = height - 4;
    _sBgView.height = bgHeight;
    
    if(!_vAutoCenter){
        CGFloat circleWH = 3;
        CGSize textHeight = [sectionTitle sizeForSelfWithFont:font limitWidth:YSHelpCenterSectionViewTitleWidth lineBreakMode:NSLineBreakByWordWrapping];
        if(textHeight.height < self.sectionTitleFontSize * 2.0f){
            /// 这种情况,只有一行
            _sCircleLabel.top = .5 * (bgHeight - circleWH);
            _sTitleLabel.top = .5 * (bgHeight - self.sectionTitleFontSize - 2);
        }else{
            _sCircleLabel.top = self.topAndBottomMargin + .5 * (self.sectionTitleFontSize - circleWH);
            _sTitleLabel.top = self.topAndBottomMargin;
        }
    }
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tap{
    if(_didClickOp){
        _didClickOp(self);
    }
}

@end
