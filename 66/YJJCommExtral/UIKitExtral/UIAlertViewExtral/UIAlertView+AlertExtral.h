//
//  UIAlertView+AlertExtral.h
//  ExtralManager
//
//  Created by YiJianjun on 14/11/6.
//  Copyright (c) 2014年 YiJianjun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertView (AlertExtral)

/**
 注意会改变delegate 为 self
 **/
- (void)showWithButtonClickedCompletion:(void (^)(NSInteger buttonIndex))completion;

/**
 注意会改变delegate 为 self,button顺序:cancelButton -> otherButton
 @param titel 标题
 @param message 消息
 @param completion 回调
 @param cancelButtonTitle 取消标题
 @param otherButtonTitles 其他标题
 **/
+ (void)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message clickedCompletion:(nullable void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
+ (void)alertWithTitle:(NSString *)title clickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
+ (void)alertWithMessage:(NSString *)message clickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
+ (void)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message clickedCompletion:(nullable void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle;
+ (void)alertWithTitle:(NSString *)title clickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle;
+ (void)alertWithMessage:(NSString *)message clickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle;
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;
+ (void)alertWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle;
+ (void)alertWithMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;
@end

NS_ASSUME_NONNULL_END
