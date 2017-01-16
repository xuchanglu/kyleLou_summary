//
//  NSMutableAttributedString+AttributedStringExtral.m
//  rwd
//
//  Created by YiJianJun on 15/10/19.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "NSMutableAttributedString+AttributedStringExtral.h"

@implementation NSMutableAttributedString (AttributedStringExtral)


- (BOOL)isVaildOfRange:(NSRange)range{
    return range.location + range.length <= [self length];
}

/**
 添加
 **/
- (void)safeAppendAttributedString:(NSAttributedString *)attString{
    if(attString && [attString isKindOfClass:[NSAttributedString class]]){
        [self appendAttributedString:attString];
    }
}

/**
 更新
 **/
- (void)safeUpdateAttributeName:(NSString *)attributeName value:(id)value range:(NSRange)range{
    if(!attributeName || ![attributeName length] || !value || ![self isVaildOfRange:range]){
        return;
    }
    
    [self removeAttribute:attributeName range:range];
    [self addAttribute:attributeName value:value range:range];
}

/**
 更新字体颜色
 **/
- (void)safeUpdateAttributeWithTextColor:(UIColor *)textColor range:(NSRange)range{
    if(!textColor || ![self isVaildOfRange:range]){
        return;
    }
    
    [self safeUpdateAttributeName:NSForegroundColorAttributeName value:textColor range:range];
}

/**
 更新字体大小
 **/
- (void)safeUpdateAttributeWithFontSize:(CGFloat)fontSize range:(NSRange)range{
    if(fontSize <= 0.0f || ![self isVaildOfRange:range]){
        return;
    }
    
    [self safeUpdateAttributeName:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:range];
}

@end
