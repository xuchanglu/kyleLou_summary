//
//  NSMutableAttributedString+AttributedStringExtral.h
//  rwd
//
//  Created by YiJianJun on 15/10/19.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (AttributedStringExtral)

/**
 添加
 **/
- (void)safeAppendAttributedString:(NSAttributedString *)attString;

/**
 更新
 **/
- (void)safeUpdateAttributeName:(NSString *)attributeName value:(id)value range:(NSRange)range;

/**
 更新字体颜色
 **/
- (void)safeUpdateAttributeWithTextColor:(UIColor *)textColor range:(NSRange)range;

/**
 更新体大小
 **/
- (void)safeUpdateAttributeWithFontSize:(CGFloat)fontSize range:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
