//
//  UIActionSeet+ActionSeetExtral.h
//  ExtralManager
//
//  Created by YiJianjun on 14/11/6.
//  Copyright (c) 2014年 YiJianjun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIActionSheet (ActionSeetExtral)
/**
 注意会改变delegate 为 self
 **/
- (void)showInView:(__weak UIView *)view withButtonClickedCompletion:(void (^)(NSInteger buttonIndex))completion;

/**
 注意会改变delegate 为 self,button顺序:destructiveButton -> otherButtons -> cancelButton
 @param titel 标题
 @param view 显示的视图
 @param completion 回调
 @param cancelButtonTitle 取消标题
 @param destructiveButtonTitle 选择的标题
 @param otherButtonTitles 其他标题
 **/
+ (void)sheetWithTitle:(NSString *)title inView:(nullable __weak UIView *)view withButtonClickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
+ (void)sheetWithTitle:(NSString *)title withButtonClickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+ (void)sheetWithTitle:(NSString *)title withButtonClickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle;
@end


NS_ASSUME_NONNULL_END
