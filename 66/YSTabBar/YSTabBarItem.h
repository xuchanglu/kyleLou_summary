//
//  YSTabBarItem.h
//  rwd
//
//  Created by Yasin-iOSer on 15/9/7.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSTabBarItem : UIView

@property (nonatomic,weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;

@property (nonatomic,strong) UIImage *iconImage;
@property (nonatomic,strong) UIImage *selectedImage;

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIColor *titleSelectedColor;

+ (instancetype)itemWithIconImage:(UIImage *)iconImage selectedImage:(UIImage *)selectedImage title:(NSString *)title titleColor:(UIColor *)titleColor titleSelectedColor:(UIColor *)titleSelectedColor bigItem:(BOOL)isBigItem;
+ (instancetype)itemWithIconImage:(UIImage *)iconImage selectedImage:(UIImage *)selectedImage title:(NSString *)title titleColor:(UIColor *)titleColor titleSelectedColor:(UIColor *)titleSelectedColor;

/// 选中
- (void)setSelected:(BOOL)selected;



@end
