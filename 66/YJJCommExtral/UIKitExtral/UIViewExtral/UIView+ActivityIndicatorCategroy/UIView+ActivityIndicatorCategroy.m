//
//  UIView+ViewExtral.m
//  WorkLogger
//
//  Created by yjj on 14-5-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "UIView+ActivityIndicatorCategroy.h"

@implementation UIView (ActivityIndicatorCategroy)

static NSInteger UIViewActivityIndicatorTag = 99999999;

- (UIActivityIndicatorView *)activityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style{
    UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)[self viewWithTag:UIViewActivityIndicatorTag];
    if(!activityIndicator){
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        activityIndicator.tag = UIViewActivityIndicatorTag;
        CGSize viewSize = self.frame.size;
        CGPoint center = CGPointMake(viewSize.width * .5f, viewSize.height * .5f);
        activityIndicator.center = center;
    }
    return activityIndicator;
}

- (void)showWhiteLargeActivityIndicator{
    [self showActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhiteLarge];
}

- (void)showWhiteActivityIndicator{
    [self showActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhite];
}

- (void)showGrayActivityIndicator{
    [self showActivityIndicatorWithStyle:UIActivityIndicatorViewStyleGray];
}

- (void)showActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style{
    UIActivityIndicatorView *activityIndicator = [self activityIndicatorWithStyle:style];
    activityIndicator.hidden = YES;
    [self addSubview:activityIndicator];
    [self bringSubviewToFront:activityIndicator];
    [UIView animateWithDuration:.2 animations:^{
        activityIndicator.hidden = NO;
    } completion:^(BOOL finished) {
        [activityIndicator startAnimating];
    }];
    
}

- (void)hideActivityIndicator{
    UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)[self viewWithTag:UIViewActivityIndicatorTag];
    [UIView animateWithDuration:.2 animations:^{
        activityIndicator.hidden = YES;
    } completion:^(BOOL finished) {
        [activityIndicator stopAnimating];
        [activityIndicator removeFromSuperview];
    }];
}

@end

