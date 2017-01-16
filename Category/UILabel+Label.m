//
//  UILabel+Label.m
//  ZTLife
//
//  Created by Leo on 15/12/3.
//  Copyright © 2015年 ZThink. All rights reserved.
//

#import "UILabel+Label.h"

@implementation UILabel (Label)

+ (UILabel *)labelText:(NSString *)content andFont:(CGFloat)font andColor:(UIColor *)textColor {
    
    UILabel *label = [[UILabel alloc]init];
    label.text = content;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:font];
    
    return label;
}

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString*)text fontSize:(CGFloat)size textColor:(UIColor *)color line:(NSInteger)line{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = color;
    label.text = [NSString stringWithFormat:@"%@",text];
    label.numberOfLines = line;
    [label sizeToFit];
    return label;
}

- (void)setLineSpacing:(CGFloat)spacingValue{
    if (!self.text) {
        return;
    }
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacingValue];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    [self setAttributedText:attributedString];
    [self sizeToFit];
}

- (void)setSpanColorByRange:(NSRange)range textColor:(UIColor *)color{
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributed addAttributes:@{NSForegroundColorAttributeName:color} range:range];
    [self setAttributedText:attributed];
    [self sizeToFit];
}

- (void)setLabelShadow{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 3;
    shadow.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:.3];
    shadow.shadowOffset = CGSizeMake(0, 2);
    
    NSDictionary *dict = @{NSShadowAttributeName:shadow};
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributedString addAttributes:dict range:NSMakeRange(0, self.text.length)];
    [self setAttributedText:attributedString];
    [self sizeToFit];
}


@end
