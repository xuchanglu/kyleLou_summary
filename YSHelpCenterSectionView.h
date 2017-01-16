//
//  YSHelpCenterSectionView.h
//  rwd
//
//  Created by Yasin-iOSer on 15/9/21.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat YSHelpCenterSectionViewDefaultHeight = 44.0f;

@interface YSHelpCenterSectionView : UITableViewHeaderFooterView

/// section index;
@property (nonatomic,assign) NSUInteger sectionIndex;
/// 选择
@property (nonatomic,assign) BOOL sectionSelected;
/// 标题
@property (nonatomic,strong) NSString *sectionTitle;
/// 字体 默认为 16
@property (nonatomic,assign) NSUInteger sectionTitleFontSize;
/// 垂直居中
@property (nonatomic,assign) BOOL vAutoCenter;
/// 上下间距 默认为 8  注意:只有vAutoCenter为NO时有效
@property (nonatomic,assign) CGFloat topAndBottomMargin;
/// 点击
@property (nonatomic,copy) void (^didClickOp)(YSHelpCenterSectionView *sectionView);

- (void)configViews;
- (void)configViewsWithSize:(CGSize)size;

+ (CGFloat)sectionViewHeightForSectionTitle:(NSString *)title font:(UIFont *)font;
+ (CGFloat)sectionViewHeightForSectionTitle:(NSString *)title font:(UIFont *)font topAndBottomMargin:(CGFloat)topAndBottomMargin;

@end

