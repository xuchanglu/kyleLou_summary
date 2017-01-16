//
//  UIView+ViewExtral.m
//  WorkLogger
//
//  Created by yjj on 14-5-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "UIView+ToastShowExtral.h"
#import "ToastManager.h"
#import <objc/runtime.h>

@implementation UIViewToastSetting

+ (instancetype)shareToastSetting{
    static UIViewToastSetting *toastSetting = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toastSetting = [[self alloc] init];
    });
    
    return toastSetting;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _toastDefaultDuration = 1.5;
        _toastDefaultPosition = Toast_Position_Center;
        _toastDefaultTitle = nil;
    }
    return self;
}

@end

@implementation UIView (ToastShowExtral)

static const char *UIViewToastAsscationKey = "___UIViewToastAsscationKey__";

- (void)setToastManager:(ToastManager *)toastMgr{
    if(!toastMgr || ![toastMgr isKindOfClass:[ToastManager class]]){
        return;
    }
    
    objc_setAssociatedObject(self, UIViewToastAsscationKey, toastMgr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ToastManager *)toastManager{
    ToastManager *toastMgr = objc_getAssociatedObject(self, UIViewToastAsscationKey);
    if(toastMgr && [toastMgr isKindOfClass:[ToastManager class]]){
        return toastMgr;
    }else{
        toastMgr = [ToastManager toastManager];
        [self setToastManager:toastMgr];
    }
    return toastMgr;
}

- (void)showMessage:(NSString *)message centerPostion:(CGPoint)centerPostion{
    [UIView showMessage:message centerPostion:centerPostion showView:self];
}

+ (ToastManager *)toastManagerForShowView:(UIView *)showView{
    UIView *showInView = showView;
    if(!showInView){
        showInView = [[[UIApplication sharedApplication] delegate] window];
    }
    
    ToastManager *toast = [showInView toastManager];
    return toast;
}

+ (void)showMessage:(NSString *)message position:(Toast_Position)position showView:(UIView *)showView{
    ToastManager *toast = [self toastManagerForShowView:showView];
    toast.settings.toastDefaultDuration = [UIViewToastSetting shareToastSetting].toastDefaultDuration;
    toast.settings.toastDefaultPosition = position;
    
    toast.showInView = showView;
    
    [toast makeToast:message];
}

+ (void)showMessage:(NSString *)message centerPostion:(CGPoint)centerPostion showView:(UIView *)showView{
    ToastManager *toast = [self toastManagerForShowView:showView];
    toast.showInView = showView;
    [toast makeToast:message duration:[UIViewToastSetting shareToastSetting].toastDefaultDuration centerPoint:centerPostion];
}

- (void)showMessage:(NSString *)message{
    if([UIScreen mainScreen].bounds.size.height == 480){
        [self showTopMessage:message];
    }else{
        [UIView showMessage:message position:[UIViewToastSetting shareToastSetting].toastDefaultPosition showView:self];
    }
}

- (void)showBottomMessage:(NSString *)message{
    [UIView showMessage:message position:Toast_Position_Bottom showView:self];
}

- (void)showTopMessage:(NSString *)message{
    [UIView showMessage:message position:Toast_Position_Top showView:self];
}

- (void)showMessage:(NSString *)message duration:(NSTimeInterval)innterval{
    [UIView showMessage:message duration:innterval position:[UIViewToastSetting shareToastSetting].toastDefaultPosition title:nil image:nil showView:self];
}

+ (void)showMessage:(NSString *)message{
    [self showMessage:message position:[UIViewToastSetting shareToastSetting].toastDefaultPosition showView:nil];
}

+ (void)showMessage:(NSString *)message centerPostion:(CGPoint)centerPostion{
    [self showMessage:message centerPostion:centerPostion showView:nil];
}

+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)interval{
    [self showMessage:message duration:interval position:[UIViewToastSetting shareToastSetting].toastDefaultPosition title:nil image:nil showView:nil];
}

+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)interval position:(Toast_Position)position title:(NSString *)title image:(UIImage *)image showView:(UIView *)showView{
    ToastManager *toast = [self toastManagerForShowView:showView];
    toast.showInView = showView;
    [toast makeToast:message duration:interval position:position title:title image:image];
}

+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)interval centerPoint:(CGPoint)centerPoint title:(NSString *)title image:(UIImage *)image showView:(UIView *)showView{
    ToastManager *toast = [self toastManagerForShowView:showView];
    toast.showInView = showView;
    [toast makeToast:message duration:interval centerPoint:centerPoint title:title image:image];
}


@end

