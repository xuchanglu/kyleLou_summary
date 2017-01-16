//
//  UIView+ViewExtral.h
//  WorkLogger
//
//  Created by yjj on 14-5-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef __UIView_Extral__
    #define __UIView_Extral__
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ViewExtral)
///添加点击取消输入
- (void)addTapToEndEditing;
///添加点击手势
- (void)addTapWithSelector:(SEL)selector;
- (void)addTapWithTarget:(id)target selector:(SEL)selector;
///添加背景图片
- (void)setBackgroundImage:(UIImage *)bgImg;
///添加背景图片
- (void)setBackgroundWithImageNamed:(NSString *)bgImgName;
///设置圆角 r半径
- (void)setCornerRadius:(CGFloat)r;
///设置为圆形
- (void)setRadiusSharp;
///设置边框
- (void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
///旋转视图
- (void)rotationDegress:(CGFloat)degress;
///删除所有子视图
- (void)removeAllSubviews;
///快速构建背景色的视图
+ (instancetype)viewWithBackgroundColor:(UIColor *)bgColor frame:(CGRect)frame;
+ (instancetype)viewWithClearBackgroundColorWithFrame:(CGRect)frame;
@end

@interface UIView (ViewCaptureExtral)
- (UIImage *)captureImage;
+ (UIImage *)captureImageForView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END


