//
//  UIScrollView+CircleScroll.h
//  CircleScroll
//
//  Created by YiJianJun on 14-7-28.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (CircleScroll)

/**需要先设置delegate
 *@warning 页数必须大于2
 *@param firstView 第一个视图,需要实现NSCoding协议
 *@param lastView 最后一个视图,需要实现NSCoding协议
 **/
- (void)setupCircleScrollWithFirstView:(UIView *)firstView lastView:(UIView *)lastView;

/**在UIScrollViewDelegate的scrollViewWillBeginDecelerating:方法中调用
 *@param firstFrame 第一个视图的frame
 *@param lastFrame 最后一个视图的frame
 **/
- (void)circleScrollViewWillBeginDeceleratingWithFirstFrame:(CGRect)firstFrame lastFrame:(CGRect)lastFrame;
@end

NS_ASSUME_NONNULL_END

