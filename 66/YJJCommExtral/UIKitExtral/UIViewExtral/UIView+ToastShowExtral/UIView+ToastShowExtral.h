//
//  UIView+ViewExtral.h
//  WorkLogger
//
//  Created by yjj on 14-5-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ToastManager.h"

#ifndef __UIView_ToastShowExtral__
    #define __UIView_ToastShowExtral__
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIViewToastSetting : NSObject

/// toast duration (default:1.5)
@property (nonatomic,assign) NSTimeInterval toastDefaultDuration;
/// toast position (default:Center)
@property (nonatomic,assign) Toast_Position toastDefaultPosition;
/// toast title (default:nil)
@property (nonatomic,strong,nullable) NSString *toastDefaultTitle;

+ (instancetype)shareToastSetting;

@end

@interface UIView (ToastShowExtral)

- (void)showMessage:(NSString *)message centerPostion:(CGPoint)centerPostion;
- (void)showMessage:(NSString *)message;
- (void)showBottomMessage:(NSString *)message;
- (void)showTopMessage:(NSString *)message;
- (void)showMessage:(NSString *)message duration:(NSTimeInterval)innterval;

+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message centerPostion:(CGPoint)centerPostion;
+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)interval;
+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)interval position:(Toast_Position)position title:(nullable NSString *)title image:(nullable UIImage *)image showView:(nullable UIView *)showView;

///position - Toast_Position
+ (void)showMessage:(NSString *)message position:(Toast_Position)position showView:(nullable UIView *)showView;
+ (void)showMessage:(NSString *)message centerPostion:(CGPoint)centerPostion showView:(nullable UIView *)showView;
+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)interval centerPoint:(CGPoint)centerPoint title:(nullable NSString *)title image:(nullable UIImage *)image showView:(nullable UIView *)showView;

@end

NS_ASSUME_NONNULL_END

