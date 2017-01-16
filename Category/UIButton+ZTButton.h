//
//  UIButton+ZTButton.h
//  ZTLife
//
//  Created by Leo on 15/12/15.
//  Copyright © 2015年 ZThink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZTButton)
/**
 *  初始化按钮
 *
 *  @param frame  按钮frame
 *  @param target 按钮在哪个类执行方法
 *  @param action 执行的方法
 *
 *  @return UIButton
 */
+ (id)buttonWithFrame:(CGRect)frame btnTag:(NSInteger)tag target:(id)target action:(SEL)action;

/**
 *  设置按钮普通状态图片
 *
 *  @param imageName 图片名称
 */
- (void)setNormalImageName:(NSString*)imageName;

/**
 *  设置按钮已选中状态图片
 *
 *  @param imageName 图片名称
 */
- (void)setSelectedImageName:(NSString*)imageName;

/**
 *  设置按钮高亮状态图片
 *
 *  @param imageName 图片名称
 */
- (void)setHighlightedImageName:(NSString*)imageName;

/**
 *  设置按钮标题及标题颜色
 *
 *  @param title 按钮标题
 *  @param color 标题颜色
 *  @param state 按钮状态
 */
- (void)setTitle:(NSString*)title titleColor:(UIColor*)color forState:(UIControlState)state;

/**
 *  设置按钮标题字体
 *
 *  @param font 字体
 */
- (void)setTitleWithFont:(UIFont *)font;


// 没有圆角的
+ (UIButton *)buttonTitle:(NSString *)title setBackground:(UIColor *)backColor andImage:(NSString *)imageName titleColor:(UIColor *)titltColor titleFont:(CGFloat)titleFont target:(id)target action:(SEL)action;


// 有圆角

+ (UIButton *)buttonTitle:(NSString *)title setBackground:(UIColor *)backColor andImage:(NSString *)imageName titleColor:(UIColor *)titltColor titleFont:(CGFloat)titleFont andCordius:(CGFloat)cordius andMask:(BOOL)mask target:(id)target action:(SEL)action;

@end
