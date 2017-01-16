//
//  UILabel+Label.h
//  ZTLife
//
//  Created by Leo on 15/12/3.
//  Copyright © 2015年 ZThink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Label)

+ (UILabel *)labelText:(NSString *)content andFont:(CGFloat)font andColor:(UIColor *)textColor;
/**
 *  快速创建一个自适应label,line为0时自适应高度，line为1时自适应宽度
 *
 *  @param frame    label frame
 *  @param text     label文字
 *  @param size     字体大小
 *  @param color    字体颜色
 *  @param line     行数
 *
 *  @return UILabel
 */
+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString*)text fontSize:(CGFloat)size textColor:(UIColor *)color line:(NSInteger)line;

/**
 *  设置label每一行文字之间的间距
 *
 *  @param spacingValue 间距值
 */
- (void)setLineSpacing:(CGFloat)spacingValue;

/**
 *  根据范围设置label的跨度文字颜色
 *
 *  @param range 范围
 */
- (void)setSpanColorByRange:(NSRange)range textColor:(UIColor*)color;

/**
 *  设置文字投影
 */
- (void)setLabelShadow;
@end
