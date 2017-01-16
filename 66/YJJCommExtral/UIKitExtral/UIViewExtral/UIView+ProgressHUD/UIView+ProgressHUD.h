//
//  UIView+ViewExtral.h
//  WorkLogger
//
//  Created by yjj on 14-5-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef __UIView_ProgressHUD__
    #define __UIView_ProgressHUD__
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIViewProgressHUDSetting : NSObject
/// HUD hold on message (defualt: 请稍后..)
@property (nonatomic,strong) NSString *holdOnMessage;
/// HUD dismiss duration (defualt: 1.0 second)
@property (nonatomic,assign) NSTimeInterval dismissTime;

+ (instancetype)shareProgressHUDSetting;

@end

@interface UIView (ProgressHUD)

///需要dismiss
- (void)showHUDHoldOn;
- (void)showHUD:(NSString *)message;

///dismiss
- (void)dismissHUD;

- (void)dismissHUDWithError:(NSString *)error __attribute__((deprecated("use dismissHUD instead.")));
- (void)dismissHUDWithSuccess:(NSString *)success __attribute__((deprecated("use dismissHUD instead.")));

///自动dismiss
- (void)showDurationHUD:(NSString *)message;
- (void)showHUD:(NSString *)message duration:(NSTimeInterval)duration;

- (void)showDurationHUDWithError:(NSString *)error __attribute__((deprecated("use showDurationHUD: instead.")));
- (void)showHUDWithError:(NSString *)error duration:(NSTimeInterval)duration __attribute__((deprecated("use showHUD:duration: instead.")));
- (void)showDurationHUDWithSuccess:(NSString *)success __attribute__((deprecated("use showDurationHUD: instead.")));
- (void)showHUDWithSuccess:(NSString *)success duration:(NSTimeInterval)duration __attribute__((deprecated("use showHUD:duration: instead.")));


/**
 以下方法添加到Window上
 **/
+ (void)showHUDHoldOn;
+ (void)showHUD:(NSString *)message;

+ (void)dismissHUD;

@end

NS_ASSUME_NONNULL_END
