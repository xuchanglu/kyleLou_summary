//
//  UIButton+ZTButton.m
//  ZTLife
//
//  Created by Leo on 15/12/15.
//  Copyright © 2015年 ZThink. All rights reserved.
//

#import "UIButton+ZTButton.h"

@implementation UIButton (ZTButton)

+ (id)buttonWithFrame:(CGRect)frame btnTag:(NSInteger)tag target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = frame;
    btn.tag = tag;
    [btn setExclusiveTouch:YES];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)setNormalImageName:(NSString *)imageName{
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)setHighlightedImageName:(NSString *)imageName{
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
}

- (void)setSelectedImageName:(NSString *)imageName{
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
}

- (void)setTitle:(NSString *)title titleColor:(UIColor *)color forState:(UIControlState)state{
    [self setTitle:title forState:state];
    [self setTitleColor:color forState:state];
}

- (void)setTitleWithFont:(UIFont *)font{
    self.titleLabel.font = font;
}

+ (UIButton *)buttonTitle:(NSString *)title setBackground:(UIColor *)backColor andImage:(NSString *)imageName titleColor:(UIColor *)titltColor titleFont:(CGFloat)titleFont target:(id)target action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = backColor;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitleColor:titltColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:titleFont];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


+ (UIButton *)buttonTitle:(NSString *)title setBackground:(UIColor *)backColor andImage:(NSString *)imageName titleColor:(UIColor *)titltColor titleFont:(CGFloat)titleFont andCordius:(CGFloat)cordius andMask:(BOOL)mask target:(id)target action:(SEL)action {
    
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = backColor;
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitleColor:titltColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:titleFont];
    button.layer.cornerRadius = cordius;
    button.layer.masksToBounds = mask;
     [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
