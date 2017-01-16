//
//  UIView+ViewExtral.m
//  WorkLogger
//
//  Created by yjj on 14-5-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "UIView+ProgressHUD.h"
#import "MBProgressHUD.h"

@implementation UIViewProgressHUDSetting

+ (instancetype)shareProgressHUDSetting{
    static UIViewProgressHUDSetting *progressHUDSetting = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        progressHUDSetting = [[self alloc] init];
    });
    
    return progressHUDSetting;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _holdOnMessage = @"请稍后..";
        _dismissTime = 1.0;
    }
    return self;
}

@end

@implementation UIView (ProgressHUD)

- (void)showHUDHoldOn{
    [self showHUD:[UIViewProgressHUDSetting shareProgressHUDSetting].holdOnMessage];
}

- (void)showHUD:(NSString *)message{
    __weak MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.label.text = message;
}

- (void)dismissHUD{
    [MBProgressHUD hideHUDForView:self animated:YES];
}

- (void)dismissHUDWithError:(NSString *)error{
    [self showHUD:error];
}

- (void)dismissHUDWithSuccess:(NSString *)success{
    [self showHUD:success];
}

///自动dismiss
- (void)showDurationHUD:(NSString *)message{
    [self showHUD:message duration:[UIViewProgressHUDSetting shareProgressHUDSetting].dismissTime];
}

- (void)showHUD:(NSString *)message duration:(NSTimeInterval)duration{
    [self showHUD:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissHUD];
    });
}

- (void)showDurationHUDWithError:(NSString *)error{
    [self showHUDWithError:error duration:[UIViewProgressHUDSetting shareProgressHUDSetting].dismissTime];
}

- (void)showHUDWithError:(NSString *)error duration:(NSTimeInterval)duration{
    [self showHUD:error duration:duration];
}

- (void)showDurationHUDWithSuccess:(NSString *)success{
    [self showHUDWithSuccess:success duration:[UIViewProgressHUDSetting shareProgressHUDSetting].dismissTime];
}

- (void)showHUDWithSuccess:(NSString *)success duration:(NSTimeInterval)duration{
    [self showHUD:success duration:duration];
}

/**
 以下方法添加到Window上
 **/
+ (UIWindow *)appWindow{
    return [[UIApplication sharedApplication].delegate window];
}

+ (void)showHUDHoldOn{
    [[self appWindow] showHUDHoldOn];
}

+ (void)showHUD:(NSString *)message{
    [[self appWindow] showHUD:message];
}

+ (void)dismissHUD{
    
}

@end
