//
//  NSAttributedString+AttributedStringExtral.m
//  rwd
//
//  Created by YiJianJun on 15/10/19.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "NSAttributedString+AttributedStringExtral.h"

@implementation NSAttributedString (AttributedStringExtral)

/// 获取常用控件的属性
/// view - label,textField,textView
+ (NSDictionary *)attributeOfFontAndColorWithView:(__weak UIView *)view{
    if(view){
        if([view isKindOfClass:[UILabel class]]){
            return [self attributeOfFontAndColorWithLabel:(UILabel *)view];
        }else if([view isKindOfClass:[UITextView class]]){
            return [self attributeOfFontAndColorWithTextView:(UITextView *)view];
        }else if([view isKindOfClass:[UITextField class]]){
            return [self attributeOfFontAndColorWithTextField:(UITextField *)view];
        }else if([view isKindOfClass:[UIButton class]]){
            return [self attributeOfFontAndColorWithButton:(UIButton *)view];
        }
    }
    
    return @{};
}

/// label
+ (NSDictionary *)attributeOfFontAndColorWithLabel:(__weak UILabel *)label{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if(label && [label isKindOfClass:[UILabel class]]){
        if(label.textColor){
            dict[NSForegroundColorAttributeName] = label.textColor;
        }
        
        if(label.font){
            dict[NSFontAttributeName] = label.font;
        }
    }
    
    return dict;
}

/// textfiled
+ (NSDictionary *)attributeOfFontAndColorWithTextField:(__weak UITextField *)textField{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if(textField && [textField isKindOfClass:[UITextField class]]){
        if(textField.textColor){
            dict[NSForegroundColorAttributeName] = textField.textColor;
        }
        
        if(textField.font){
            dict[NSFontAttributeName] = textField.font;
        }
    }
    
    return dict;
}

/// textView
+ (NSDictionary *)attributeOfFontAndColorWithTextView:(__weak UITextView *)textView{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if(textView && [textView isKindOfClass:[UITextView class]]){
        if(textView.textColor){
            dict[NSForegroundColorAttributeName] = textView.textColor;
        }
        
        if(textView.font){
            dict[NSFontAttributeName] = textView.font;
        }
    }
    
    return dict;
}

/// button
+ (NSDictionary *)attributeOfFontAndColorWithButton:(__weak UIButton *)button{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if(button && [button isKindOfClass:[UIButton class]]){
        UILabel *titleLabel = button.titleLabel;
        if(titleLabel.textColor){
            dict[NSForegroundColorAttributeName] = titleLabel.textColor;
        }
        
        if(titleLabel.font){
            dict[NSFontAttributeName] = titleLabel.font;
        }
    }
    
    return dict;
}


/**
 得到,对应的实例
 **/
+ (instancetype)attributedStringWithString:(NSString *)aString attribute:(NSDictionary *)attribute{
    if(!aString || ![aString length] || !attribute || ![attribute count]){
        return nil;
    }
    NSAttributedString *attStr = [[self alloc] initWithString:aString attributes:attribute];
    return attStr;
}

/**
 得到实例,fontSize,textColor
 **/
+ (instancetype)attributedStringWithString:(NSString *)aString fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor{
    if(!aString || ![aString length] || !textColor || fontSize <= 0.0f){
        return nil;
    }
    
    NSDictionary *attDict = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:textColor};
    return [self attributedStringWithString:aString attribute:attDict];
}

/**
 得到,对应view的实例
 **/
+ (instancetype)attributedStringWithString:(NSString *)aString view:(__weak UIView *)view{
    if(!aString || ![aString length] || !view){
        return nil;
    }
    
    NSDictionary *attDict = [self attributeOfFontAndColorWithView:view];
    if(!attDict || ![attDict count]){
        return nil;
    }
    
    return [self attributedStringWithString:aString attribute:attDict];
}



@end
