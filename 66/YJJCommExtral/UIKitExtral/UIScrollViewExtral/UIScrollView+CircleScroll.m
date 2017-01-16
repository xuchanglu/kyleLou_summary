//
//  UIScrollView+CircleScroll.m
//  CircleScroll
//
//  Created by YiJianJun on 14-7-28.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import "UIScrollView+CircleScroll.h"

@implementation UIScrollView (CircleScroll)

///需要先设置delegate 页数必须大于2
- (void)setupCircleScrollWithFirstView:(UIView *)firstView lastView:(UIView *)lastView{
    self.bounces = YES;
    self.alwaysBounceHorizontal = YES;
    self.pagingEnabled = YES;
    
    UIView *fView = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:lastView]];
    CGRect frame = fView.frame;
    frame.origin.x = 0.0f - frame.size.width;
    [fView setFrame:frame];
    [self addSubview:fView];
    
    UIView *sView = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:firstView]];
    frame = sView.frame;
    frame.origin.x = self.contentSize.width;
    [sView setFrame:frame];
    [self addSubview:sView];
}

- (void)circleScrollViewWillBeginDeceleratingWithFirstFrame:(CGRect)firstFrame lastFrame:(CGRect)lastFrame{
    CGFloat x = self.contentOffset.x;
    CGFloat width = self.contentSize.width - lastFrame.size.width;
    if(x >= 0 && x <= width){
        return;
    }
    if(x < 0){
        NSLog(@"scroll to last");
        [UIView animateWithDuration:0.2f animations:^{
            [self setContentOffset:CGPointMake(0.0f - lastFrame.size.width, lastFrame.origin.y)];
        } completion:^(BOOL finished) {
            [self scrollRectToVisible:lastFrame animated:NO];
        }];
//        [self setContentOffset:lastFrame.origin];
    }else if(x > width){
        NSLog(@"scroll to first");
        [UIView animateWithDuration:0.2f animations:^{
            [self setContentOffset:CGPointMake(self.contentSize.width, firstFrame.origin.y)];
        } completion:^(BOOL finished) {
            [self scrollRectToVisible:firstFrame animated:NO];
        }];
//        [self setContentOffset:firstFrame.origin];
    }
}

@end
