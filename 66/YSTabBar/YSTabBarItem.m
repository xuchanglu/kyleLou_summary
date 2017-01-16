//
//  YSTabBarItem.m
//  rwd
//
//  Created by Yasin-iOSer on 15/9/7.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "YSTabBarItem.h"

@interface YSTabBarItem (){
    BOOL _bSelect;
}

@end

@implementation YSTabBarItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)itemWithIconImage:(UIImage *)iconImage selectedImage:(UIImage *)selectedImage title:(NSString *)title titleColor:(UIColor *)titleColor titleSelectedColor:(UIColor *)titleSelectedColor{
    return [self itemWithIconImage:iconImage selectedImage:selectedImage title:title titleColor:titleColor titleSelectedColor:titleSelectedColor bigItem:NO];
}

+ (instancetype)itemWithIconImage:(UIImage *)iconImage selectedImage:(UIImage *)selectedImage title:(NSString *)title titleColor:(UIColor *)titleColor titleSelectedColor:(UIColor *)titleSelectedColor bigItem:(BOOL)isBigItem{
    
    NSString *nibNamed = isBigItem?[NSStringFromClass([self class]) stringByAppendingString:@"-big"]:NSStringFromClass([self class]);
    YSTabBarItem *item = [[[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil] firstObject];
    item.iconImage = iconImage;
    item.selectedImage = selectedImage;
    item.title = title;
    item.titleColor = titleColor;
    item.titleSelectedColor = titleSelectedColor;
    
    item.titleLabel.text = title;
    [item setSelected:NO];
    
    return item;
}

- (void)setSelected:(BOOL)selected{
    if(!selected){
        _iconImageView.image = _iconImage;
        _titleLabel.textColor = _titleColor;
    }else{
        _iconImageView.image = _selectedImage;
        _titleLabel.textColor = _titleSelectedColor;
    }
}

@end


