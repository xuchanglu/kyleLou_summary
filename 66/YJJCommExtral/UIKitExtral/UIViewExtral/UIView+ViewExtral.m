//
//  UIView+ViewExtral.m
//  WorkLogger
//
//  Created by yjj on 14-5-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "UIView+ViewExtral.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@implementation UIView (ViewExtral)

- (void)addTapToEndEditing{
    [self addTapWithTarget:self selector:@selector(___tapGestureAction:)];
}

- (void)___tapGestureAction:(UITapGestureRecognizer *)tap{
    [self endEditing:YES];
}

///添加点击手势
- (void)addTapWithSelector:(SEL)selector{
    [self addTapWithTarget:self selector:selector];
}

- (void)addTapWithTarget:(id)target selector:(SEL)selector{
    if(!target || !selector){
        return;
    }
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tapGesture];
}

- (void)setBackgroundImage:(UIImage *)bgImg{
    if(bgImg){
        [self setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
    }
}

- (void)setBackgroundWithImageNamed:(NSString *)bgImgName{
    UIImage *bgImg = [UIImage imageNamed:bgImgName];
    if(bgImg){
        [self setBackgroundImage:bgImg];
    }
}

- (void)setCornerRadius:(CGFloat)r{
    if(r < 1e-6){
        return;
    }
    
    CALayer *layer = self.layer;
    [layer setCornerRadius:r];
    [layer setMasksToBounds:YES];
}

///设置为圆形
- (void)setRadiusSharp{
    [self setCornerRadius:self.frame.size.width * 0.5f];
}

///设置边框
- (void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    CALayer *layer = self.layer;
    layer.borderWidth = borderWidth;
    layer.borderColor = borderColor.CGColor;
    layer.masksToBounds = YES;
}

- (void)rotationDegress:(CGFloat)degress{
    CALayer *layer = self.layer;
    CGAffineTransform transform = CGAffineTransformMakeRotation(degress);
    [layer setAffineTransform:transform];
}

///删除所有子视图  , 让数组中的每个元素 都调用 aMethod
- (void)removeAllSubviews{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

///快速构建背景色的视图
+ (instancetype)viewWithBackgroundColor:(UIColor *)bgColor frame:(CGRect)frame{
    UIView *view = [[self alloc] initWithFrame:frame];
    view.backgroundColor = bgColor;
    return view;
}

+ (instancetype)viewWithClearBackgroundColorWithFrame:(CGRect)frame{
    return [self viewWithBackgroundColor:[UIColor clearColor] frame:frame];
}
@end

@implementation UIView (ViewCaptureExtral)
- (UIImage *)captureImage{
    return [UIView captureImageForView:self];
}

+ (UIImage *)captureImageForView:(UIView *)view{
    CGRect bounds = view.bounds;
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:contextRef];
    
    UIImage *captureImage = UIGraphicsGetImageFromCurrentImageContext();
    return captureImage;
}
@end
