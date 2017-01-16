//
//  NSAttributedString+AttributedStringExtral.h
//  rwd
//
//  Created by YiJianJun on 15/10/19.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (AttributedStringExtral)

/// 获取常用控件的属性

/// view - label,textField,textView
+ (NSDictionary *)attributeOfFontAndColorWithView:(__weak UIView *)view;
/// label
+ (NSDictionary *)attributeOfFontAndColorWithLabel:(__weak UILabel *)label;
/// textfiled
+ (NSDictionary *)attributeOfFontAndColorWithTextField:(__weak UITextField *)textField;
/// textView
+ (NSDictionary *)attributeOfFontAndColorWithTextView:(__weak UITextView *)textView;
/// button
+ (NSDictionary *)attributeOfFontAndColorWithButton:(__weak UIButton *)button;

/**
 得到,对应的实例
 **/
+ (nullable instancetype)attributedStringWithString:(NSString *)aString attribute:(NSDictionary *)attribute;

/**
 得到实例,fontSize,textColor
 **/
+ (nullable instancetype)attributedStringWithString:(NSString *)aString fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor;

/**
 得到,对应view的实例
 **/
+ (nullable instancetype)attributedStringWithString:(NSString *)aString view:(__weak UIView *)view;

@end

NS_ASSUME_NONNULL_END
